# Extra stuff

newref!(::Type{Ref{Region}}, value) = Ref{Region}(Region(value))

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

function getinfo(agent::Agent, attribute::AgentInfo, value::String)
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), Status,
          (Agent, AgentInfo, Cstring), agent, attribute, value)
end

function getinfo(agent::Agent, attribute::AgentInfo, value::Ref{T}) where T
    ccall((:hsa_agent_get_info, "libhsa-runtime64"), Status,
          (Agent, AgentInfo, Ref{T}), agent, attribute, value)
end

function getinfo(isa::ISA, attribute::ISAInfo, value::Ref{T}) where T
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), Status,
          (ISA, ISAInfo, Ref{T}), isa, attribute, value)
end

function getinfo(isa::ISA, attribute::ISAInfo, value::String)
    ccall((:hsa_isa_get_info_alt, "libhsa-runtime64"), Status,
          (ISA, ISAInfo, Cstring), isa, attribute, value)
end

function getinfo(exsym::ExecutableSymbol, attribute::ExecutableSymbolInfo, value::String)
    ccall((:hsa_executable_symbol_get_info, "libhsa-runtime64"), Status,
          (ExecutableSymbol, ExecutableSymbolInfo, Cstring), exsym, attribute, value)
end

function memory_allocate(region::Region, size::Integer, ref::Ref{Ptr{T}}) where T
    ccall((:hsa_memory_allocate, "libhsa-runtime64"), Status,
          (Region, Csize_t, Ref{Ptr{T}}), region, size, ref)
end

#= FIXME?
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

