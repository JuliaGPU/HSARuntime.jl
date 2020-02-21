
function wrap_fun!(ctx::AbstractContext, cursor::CLFunctionDecl)
    func_type = type(cursor)
    func_name = isempty(ctx.force_name) ? Symbol(spelling(cursor)) : ctx.force_name
    ret_type = :Cint
    args = function_args(cursor)
    arg_types = [argtype(func_type, i) for i in 0:length(args)-1]
    arg_reps = clang2julia.(arg_types)

    for (i, arg) in enumerate(arg_reps)
        if Meta.isexpr(arg, :curly) && first(arg.args) == :NTuple
            arg_reps[i] = Expr(:curly, :Ref, last(arg.args))
        end
        if Meta.isexpr(arg, :curly) && first(arg.args) == :Ptr
            arg_reps[i] = Expr(:curly, :Ref, last(arg.args))
        end
    end

    arg_count = 0
    arg_names = map(args) do x
        n = name_safe(name(x))
        s = !isempty(n) ? n : "arg"*string(arg_count+=1)
        Symbol(s)
    end

    signature = efunsig(Symbol(spelling(cursor)[5:end]), arg_names, arg_reps)
    body = eccall(func_name, Symbol(ctx.libname), ret_type, arg_names, arg_reps)
    push!(ctx.api_buffer, Expr(:function, signature, Expr(:block, body)))

    return ctx
end

function eccall(func_name::Symbol, libname::Symbol, rtype, args, types)
    :(ccall(($(QuoteNode(func_name)), $(QuoteNode(libname))),
        $rtype,
        $(Expr(:tuple, types...)),
        $(args...))
     )
end

function is_ptr_type_expr(@nospecialize t)
    (t === :Cstring || t === :Cwstring) && return true
    isa(t, Expr) || return false
    t = t::Expr
    t.head === :curly && t.args[1] === :Ptr
end

function efunsig(name::Symbol, args::Vector{Symbol}, types)
    x = [is_ptr_type_expr(t) ? a : Expr(:(::), a, t) for (a,t) in zip(args,types)]
    Expr(:call, name, x...)
end

function get_raw_comment(cursor::CLCursor)
    stringptr = clang_Cursor_getRawCommentText(cursor.cursor)
    if stringptr.data == C_NULL
        return nothing
    else
        cstring = clang_getCString(stringptr)
        return unsafe_string(cstring)
    end
end

function get_parsed_comment(cursor::CLCursor)
end 
function sort_cursors(cursors::Vector{CLMacroDefinition})
    cursor_names = spelling.(cursors)
    cursor_dict = Dict(zip(cursor_names, cursors))
    sort!(unique!(cursor_names))
    sorted_cursors = [cursor_dict[cursor_names[j]] for j in 1:length(cursor_names)]
    return sorted_cursors
end
