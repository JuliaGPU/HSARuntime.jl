
mutable struct HSAArray{T,N} <: AbstractArray{T,N}
    size::Dims{N}
    handle::Ptr{T}
end

# TODO: Support non-isbitstype allocations
function HSAArray(agent::HSAAgent, ::Type{T}, size::NTuple{N,Int}) where {T,N}
    @assert isprimitivetype(T) "$T is not a primitive type"
    @assert all(x -> x > 0, size) "Invalid array size: $size"

    region = get_region(agent, :finegrained)
    nbytes = sizeof(T) * prod(size)
    handle = Ref{Ptr{T}}()
    HSA.memory_allocate(region[], nbytes, handle) |> check
    arr = HSAArray{T,N}(size, handle[])

    finalizer(arr) do arr
        HSA.memory_free(arr.handle) |> check
    end

    return arr
end
HSAArray(::Type{T}, size::NTuple{N,Int}) where {T,N} = HSAArray(DEFAULT_AGENT[], T, size)

### HSAArray Methods ###

function HSAArray(agent::HSAAgent, arr::Array{T,N}) where {T,N}
    harr = HSAArray(agent, T, size(arr))
    for idx in eachindex(arr)
        harr[idx] = arr[idx]
    end
    return harr
end
HSAArray(arr::Array{T,N}) where {T,N} = HSAArray(DEFAULT_AGENT[], arr)

function Array(harr::HSAArray{T,N}) where {T,N}
    arr = Array{T}(undef, size(harr))
    ref_arr = Ref(arr)
    GC.@preserve ref_arr begin
        ccall(
            :memcpy,
            Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            ref_arr,
            harr.handle,
            sizeof(arr),
        )
    end
    return harr
end

Base.pointer(arr::HSAArray) = arr.handle
Base.IndexStyle(::Type{<:HSAArray}) = Base.IndexLinear()
Base.IndexStyle(::HSAArray) = Base.IndexLinear()
function Base.iterate(A::HSAArray, i = 1) # copy-pasta from Base
    Base.@_inline_meta
    (i % UInt) - 1 < length(A) ? (@inbounds A[i], i + 1) : nothing
end
Base.similar(arr::HSAArray{T,N}) where {T,N} = HSAArray(T, size(arr))
Base.similar(agent, arr::HSAArray{T,N}) where {T,N} = HSAArray(agent, T, size(arr))

Base.size(arr::HSAArray) = arr.size
Base.length(arr::HSAArray) = sum(size(arr))

function Base.fill!(arr::HSAArray{T,N}, value::T) where {T,N}
    for idx = 1:length(arr)
        arr[idx] = value
    end
end
@inline function Base.getindex(arr::HSAArray{T,N}, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_load(pointer(arr), idx)::T
end
@inline function Base.setindex!(arr::HSAArray{T,N}, value, idx) where {T,N}
    @boundscheck checkbounds(arr, idx)
    Base.unsafe_store!(pointer(arr), value, idx)
end

