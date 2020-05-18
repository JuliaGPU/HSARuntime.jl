@testset "Agent" begin
    @testset "Default selection" begin
        agent = get_default_agent()
        @test agent !== nothing

        ROCr.set_default_agent!(:gpu)
        agent = get_default_agent()
        @test ROCr.device_type(agent) == :gpu

        agent_name = ROCr.get_name(agent)
        @test length(agent_name) > 0
        @test !occursin('\0', agent_name)
    end

    @testset "ISAs" begin
        agent = get_default_agent()
        agent_isa = get_first_isa(agent)
        @test length(agent_isa) > 0
    end
end
