module HSARuntime

# copied from CUDAdrv/src/CUDAdrv.jl
const ext = joinpath(dirname(@__DIR__), "deps", "ext.jl")
isfile(ext) ||
    error("HSARuntime.jl has not been built, please run Pkg.build(\"HSARuntime\").")
include(ext)
if !configured
    # default (non-functional) values for critical variables,
    # making it possible to _load_ the package at all times.
    const libhsaruntime_version = v"0.0"
    const libhsaruntime_vendor = "none"
    const libhsaruntime_path = nothing
end

atexit() do
    configured && HSA.shut_down()
end

### Imports ###

using CEnum
using Setfield
using Libdl

### Exports ###

export HSAAgent, HSAQueue, HSAExecutable, HSAKernelInstance, HSAArray, HSASignal
export get_agents, profile, get_first_isa, launch!
export get_default_agent, get_default_queue

### HSA Runtime Wrapper ###

include(joinpath(@__DIR__, "HSA", "HSA.jl"))
import .HSA: Agent, Queue, Executable, Status, Signal

include("extras.jl")
include("util.jl")
include("agent.jl")
include("queue.jl")
include("signal.jl")

### Types ###
mutable struct HSAExecutable
    agent::HSAAgent
    executable::Ref{HSA.Executable}
    data::Vector{UInt8}
end

mutable struct HSAKernelInstance{T<:Tuple}
    exe::HSAExecutable
    sym::String
    args::T
    # FIXME: Stop being lazy and put in some damn types!
    kernel_object::Any
    kernarg_segment_size::Any
    group_segment_size::Any
    private_segment_size::Any
    kernarg_address::Ref{Ptr{Nothing}}
end

function iterate_exec_agent_syms_cb(
    exe::HSA.Executable,
    agent::HSA.Agent,
    sym::HSA.ExecutableSymbol,
    sym_ref::Ptr{Cvoid},
)

    sym_ref = Base.unsafe_convert(Ptr{HSA.ExecutableSymbol}, sym_ref)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE, sym_type) |> check

    if sym_type[] == HSA.SYMBOL_KIND_KERNEL
        len = Ref(0)
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
        name = Vector{UInt8}(undef, len[])
        getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
        @debug "    Symbol Name: $(String(name))"
        Base.unsafe_store!(sym_ref, sym)
    end

    return HSA.STATUS_SUCCESS
end

function iterate_exec_prog_syms_cb(exe::HSA.Executable, sym::HSA.ExecutableSymbol, data)
    sym_type = Ref{HSA.SymbolKind}()
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_TYPE, sym_type) |> check

    #if sym_type[] == HSA.SYMBOL_KIND_KERNEL
    len = Ref(0)
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME_LENGTH, len) |> check
    name = Vector{UInt8}(undef, len[])
    getinfo(sym, HSA.EXECUTABLE_SYMBOL_INFO_NAME, name) |> check
    @debug "   Symbol Name: $(String(name))"
    #end
    return HSA.STATUS_SUCCESS
end

### Constructors and Finalizers ###
function HSAExecutable(filename::String)
    data = read(filename)
    HSAExecutable(data)
end

HSAExecutable(data::Vector{UInt8}) = HSAExecutable(get_default_agent(), data)

function HSAExecutable(agent::HSAAgent, data::Vector{UInt8})
    #= NOTE: Everything I can see indicates that profile is always FULL
    profile = Ref{HSA.Profile}()
    HSA.agent_get_info(agent.agent, HSA.AGENT_INFO_PROFILE, profile) |> check
    =#

    code_object_reader = Ref{HSA.CodeObjectReader}(HSA.CodeObjectReader(0))
    HSA.code_object_reader_create_from_memory(data, sizeof(data), code_object_reader) |>
    check

    executable = Ref{HSA.Executable}()
    HSA.executable_create_alt(
        HSA.PROFILE_BASE,
        HSA.DEFAULT_FLOAT_ROUNDING_MODE_NEAR,
        C_NULL,
        executable,
    ) |> check

    HSA.executable_load_agent_code_object(
        executable[],
        agent.agent,
        code_object_reader[],
        C_NULL,
        C_NULL,
    ) |> check

    HSA.executable_freeze(executable[], "") |> check
    HSA.code_object_reader_destroy(code_object_reader[]) |> check

    exe = HSAExecutable(agent, executable, data)

    finalizer(exe) do exe
        HSA.executable_destroy(exe.executable[]) |> check
    end

    return exe
end

function HSAKernelInstance(exe::HSAExecutable, symbol::String, args::Tuple)
    agent_func = @cfunction(
        iterate_exec_agent_syms_cb,
        HSA.Status,
        (HSA.Executable, HSA.Agent, HSA.ExecutableSymbol, Ptr{Cvoid})
    )
    prog_func = @cfunction(
        iterate_exec_prog_syms_cb,
        HSA.Status,
        (HSA.Executable, HSA.ExecutableSymbol, Ptr{Cvoid})
    )
    exec_symbol = Ref{HSA.ExecutableSymbol}()
    @debug "Agent symbols"
    HSA.executable_iterate_agent_symbols(
        exe.executable[],
        exe.agent.agent,
        agent_func,
        exec_symbol,
    ) |> check
    #@debug "Program symbols"
    #hsa_executable_iterate_program_symbols(exe.executable[], prog_func, C_NULL) |> check

    # TODO: Conditionally disable once ROCR is fixed
    if !isassigned(exec_symbol)
        agent_ref = Ref(exe.agent.agent)
        GC.@preserve agent_ref begin
            HSA.executable_get_symbol_by_name(
                exe.executable[],
                symbol,
                agent_ref,
                exec_symbol,
            ) |> check
        end
    end

    kernel_object = Ref{UInt64}(0)
    getinfo(exec_symbol[], HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_OBJECT, kernel_object) |> check

    kernarg_segment_size = Ref{UInt32}(0)
    getinfo(
        exec_symbol[],
        HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_KERNARG_SEGMENT_SIZE,
        kernarg_segment_size,
    ) |> check

    if kernarg_segment_size[] == 0
        # FIXME: Hidden arguments!
        kernarg_segment_size[] = sum(sizeof.(args))
    end

    group_segment_size = Ref{UInt32}(0)
    getinfo(
        exec_symbol[],
        HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_GROUP_SEGMENT_SIZE,
        group_segment_size,
    ) |> check

    private_segment_size = Ref{UInt32}(0)
    getinfo(
        exec_symbol[],
        HSA.EXECUTABLE_SYMBOL_INFO_KERNEL_PRIVATE_SEGMENT_SIZE,
        private_segment_size,
    ) |> check

    finegrained_region = get_region(exe.agent, :finegrained)
    kernarg_region = get_region(exe.agent, :kernarg)

    # Allocate the kernel argument buffer from the correct region
    kernarg_address = Ref{Ptr{Nothing}}()
    HSA.memory_allocate(kernarg_region[], kernarg_segment_size[], kernarg_address) |> check
    ctr = 0x0

    for arg in args
        rarg = Ref(arg)
        ccall(
            :memcpy,
            Cvoid,
            (Ptr{Cvoid}, Ptr{Cvoid}, Csize_t),
            kernarg_address[] + ctr,
            rarg,
            sizeof(arg),
        )
        ctr += sizeof(arg)
    end

    kernel = HSAKernelInstance(
        exe,
        symbol,
        args,
        kernel_object,
        kernarg_segment_size,
        group_segment_size,
        private_segment_size,
        kernarg_address,
    )
    finalizer(kernel) do kernel
        HSA.memory_free(kernel.kernarg_address[]) |> check
    end
    return kernel
end

@eval atomic_store_n!(x::Ptr{UInt16}, v::UInt16) = Base.llvmcall(
    $"""
%ptr = inttoptr i$(Sys.WORD_SIZE) %0 to i16*
store atomic i16 %1, i16* %ptr release, align 16
ret void
""",
    Cvoid,
    Tuple{Ptr{UInt16},UInt16},
    Base.unsafe_convert(Ptr{UInt16}, x),
    v,
)

launch!(kernel::HSAKernelInstance; kwargs...) = launch!(get_default_queue(), kernel, HSASignal(); kwargs...)

function launch!(
    queue::HSAQueue,
    kernel::HSAKernelInstance,
    signal::HSASignal;
    workgroup_size = nothing,
    grid_size = nothing,
)
    @assert workgroup_size !== nothing "Must specify workgroup_size kwarg"
    @assert grid_size !== nothing "Must specify grid_size kwarg"

    agent = queue.agent
    queue = queue.queue
    signal = signal.signal
    args = kernel.args

    # Obtain the current queue write index and queue size
    _queue_size = Ref{UInt32}(0)
    getinfo(agent.agent, HSA.AGENT_INFO_QUEUE_MAX_SIZE, _queue_size) |> check
    queue_size = _queue_size[]
    write_index = HSA.queue_add_write_index_scacq_screl(queue[], UInt64(1))

    # Yield until queue has space
    while true
        read_index = HSA.queue_load_read_index_scacquire(queue[])
        if write_index < read_index + queue_size
            break
        end
        yield()
    end

    # TODO: Make this less ugly
    dispatch_packet = Ref{HSA.KernelDispatchPacket}()
    ccall(
        :memset,
        Cvoid,
        (Ptr{Cvoid}, Cint, Csize_t),
        dispatch_packet,
        0,
        sizeof(dispatch_packet[]),
    )
    _packet = dispatch_packet[]
    @set! _packet.setup = 0
    @set! _packet.setup |= 3 << Int(HSA.KERNEL_DISPATCH_PACKET_SETUP_DIMENSIONS)
    @set! _packet.workgroup_size_x = workgroup_size[1]
    @set! _packet.workgroup_size_y = workgroup_size[2]
    @set! _packet.workgroup_size_z = workgroup_size[3]
    @set! _packet.grid_size_x = grid_size[1]
    @set! _packet.grid_size_y = grid_size[2]
    @set! _packet.grid_size_z = grid_size[3]
    @set! _packet.completion_signal = signal[]
    @set! _packet.kernel_object = kernel.kernel_object[]
    @set! _packet.kernarg_address = kernel.kernarg_address[]
    @set! _packet.private_segment_size = kernel.private_segment_size[]
    @set! _packet.group_segment_size = kernel.group_segment_size[]
    dispatch_packet = Ref{HSA.KernelDispatchPacket}(_packet)

    _queue = unsafe_load(queue[])
    queueMask = UInt32(_queue.size - 1)
    baseaddr_ptr = Ptr{HSA.KernelDispatchPacket}(_queue.base_address)
    baseaddr_ptr += sizeof(HSA.KernelDispatchPacket) * (write_index & queueMask)
    dispatch_packet_ptr =
        Base.unsafe_convert(Ptr{HSA.KernelDispatchPacket}, dispatch_packet)
    unsafe_copyto!(baseaddr_ptr, dispatch_packet_ptr, 1)

    # Atomically store the header
    header = Ref{UInt16}(0)
    header[] |= Int(HSA.FENCE_SCOPE_SYSTEM) << Int(HSA.PACKET_HEADER_ACQUIRE_FENCE_SCOPE)
    header[] |= Int(HSA.FENCE_SCOPE_SYSTEM) << Int(HSA.PACKET_HEADER_RELEASE_FENCE_SCOPE)
    header[] |= Int(HSA.PACKET_TYPE_KERNEL_DISPATCH) << Int(HSA.PACKET_HEADER_TYPE)
    atomic_store_n!(Base.unsafe_convert(Ptr{UInt16}, baseaddr_ptr), header[])

    # Ring the doorbell to dispatch the kernel
    HSA.signal_store_relaxed(_queue.doorbell_signal, Int64(write_index))
    signal
end

include("memory.jl")
include("array.jl")

function __init__()
    # We want to always be able to load the package, regardless of
    # whether HSA libraries are found
    configured || return

    # Make sure we load the library found by the last `] build`
    push!(Libdl.DL_LOAD_PATH, dirname(libhsaruntime_path))
    # TODO: Do the same (if possible) for the debug library

    HSA.init() |> check

    agents = get_agents(:gpu)
    if length(agents) > 0
        DEFAULT_AGENT[] = first(agents)
    end
end

end
