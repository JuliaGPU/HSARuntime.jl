# Extra stuff

newref!(::Type{Ref{HSA.Region}}, value) = Ref{HSA.Region}(HSA.Region(value))

# Memory
memset!(ref::Ref{T}, value::T) where T<:Integer = _memset!(ref, value, T)

function _memset!(ref, value, ::Type{T}; len=1) where T
    ptr = Base.unsafe_convert(Ptr{T}, ref)
    for i in 1:len
        unsafe_store!(ptr, value, i)
    end
end

function _memset!(ref::Ref{Ptr{Nothing}}, value; len=1)
    ptr = Base.unsafe_convert(Ptr{UInt8}, ref[])
    value = UInt8(value)
    for i in 1:len
        unsafe_store!(ptr, value, i)
    end
end
    
# Overloads for interface functions

function getinfo(agent::Agent, attribute::HSA.AgentInfo,
                 value::Union{Vector,Base.RefValue,String})
    #TODO: maybe do allocation/create Refs here 
    # based on value of AgentInfo
    # therefore we can omit value argument in getinfo() calls
    HSA.agent_get_info(agent, attribute, value)
end

function getinfo(isa::HSA.ISA, attribute::HSA.ISAInfo,
                 value::Union{Vector,Base.RefValue,String})
    # should allocate based on ISAInfo
    HSA.isa_get_info_alt(isa, attribute, value)
end

function getinfo(exsym::HSA.ExecutableSymbol, attribute::HSA.ExecutableSymbolInfo,
                 value::Union{Vector,Base.RefValue,String})
    # should allocated based on ExecutableSymbolInfo
    HSA.executable_symbol_get_info(exsym, attribute, value)
end

function memory_allocate(region::HSA.Region, size::Integer, ref::Ref{Ptr{T}}) where T
    ccall((:hsa_memory_allocate, "libhsa-runtime64"), Status,
          (HSA.Region, Csize_t, Ref{Ptr{T}}), region, size, ref)
end

#= FIXME ???
Base.setproperty!(ref::Ref{T}, value, prop::Symbol) where T<:HSA_MUTABLE_TYPES =
    setproperty!(ref, value, Val(prop)
@generated function Base.setproperty!(ref::Ref{T}, value, prop::Val{V}) where {T<:HSA_MUTABLE_TYPES,V} =
    ftype = fieldtype(ref.parameters[1], V)
    return quote
        ptr = Ptr{$ftype}
        unsafe_store!(ptr, 
    end
end

function memset!(ref::Ref{Nothing}, value)
    _ptr = Base.unsafe_convert(Ptr{Nothing}, ref)
    ptr = Base.unsafe_convert(Ptr{UInt}, _ptr)
    value = UInt(value)
    unsafe_store!(ptr, value)
end
=#

