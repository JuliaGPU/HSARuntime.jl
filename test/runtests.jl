using ROCr
using ROCr.HSA
using Test

if ROCr.configured
    @testset "HSA Status Error" begin
        errorcode = ROCr.HSAError(HSA.STATUS_SUCCESS)
        @test ROCr.description(errorcode) == "HSA_STATUS_SUCCESS: The function has been executed successfully."
    end
    agents = get_agents()
    if length(agents) > 0
        include("agent.jl")
        include("array.jl")
        include("memory.jl")

        # TODO Replace the AMDGPUnative vadd test with one using HSACOs.
        #=
        if AMDGPUnative.configured
            include("vadd.jl")
        else
            @warn "AMDGPUnative.jl has not been configured; skipping on-device tests"
        end
        =#
    else
        @warn "No devices detected; skipping runtime tests"
    end
else
    error("ROCr.jl has not been configured; skipping all tests")
end
