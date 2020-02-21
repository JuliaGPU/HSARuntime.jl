using Clang, Clang.LibClang
using CEnum

include("clanghelpers.jl")

const HSA_INCLUDE = joinpath("..", "deps", "include", "hsa") |> normpath
const HSA_HEADERS = [joinpath(HSA_INCLUDE, header) for header in readdir(HSA_INCLUDE) if endswith(header, ".h")]


ctx = DefaultContext()

parse_headers!(ctx, HSA_HEADERS,
               args=["-I", joinpath(HSA_INCLUDE, ".."), "-fparse-all-comments"],
               includes=vcat(HSA_INCLUDE, CLANG_INCLUDE),
               flags = CXTranslationUnit_DetailedPreprocessingRecord
               )

ctx.libname = "libhsa"
ctx.options["is_function_strictly_typed"] = true
ctx.options["is_struct_mutable"] = false
    
blacklist = ["unix", "linux"]
enums     = Vector{CLCursor}()
types     = Vector{CLCursor}()
macrodefs = Vector{CLCursor}()
functions = Vector{CLCursor}()
vardecl   = Vector{CLCursor}()
remaining = Vector{CLCursor}()

for trans_unit in ctx.trans_units

    root_cursor = getcursor(trans_unit)
    push!(ctx.cursor_stack, root_cursor)
    header = spelling(root_cursor)
    ctx.children = children(root_cursor)

    for (i, child) in enumerate(ctx.children)
        # Cursor properties
        child_name = name(child)
        child_kind = kind(child)
        # ctx.children_index = i
        
        # Skip compiler constants/garbage and type aliasing
        startswith(child_name, "_")                 && continue
        child_kind == CXCursor_MacroInstantiation   && continue
        child_kind == CXCursor_LastPreprocessing    && continue
        child_name ∈ blacklist                      && continue
        
        child_kind == CXCursor_TypedefDecl      && (push!(types, child);     continue)
        child_kind == CXCursor_MacroDefinition  && (push!(macrodefs, child); continue)
        child_kind == CXCursor_FunctionDecl     && (push!(functions, child); continue)
        child_kind == CXCursor_VarDecl          && (push!(vardecl, child);   continue)
        if child_kind ∈ (CXCursor_EnumDecl, CXCursor_EnumConstantDecl)
            push!(enums, child)
            continue
        end
        push!(remaining, child)
    end
end


api_file = joinpath(@__DIR__, "libhsa_api.jl")
api_stream = open(api_file, "w")
print_buffer(api_stream, ctx.api_buffer)
empty!(ctx.api_buffer)
close(api_stream)

common_file = joinpath(@__DIR__, "libhsa_common.jl")
open(common_file, "w") do f
    print_buffer(f, dump_to_buffer(ctx.common_buffer))
end
