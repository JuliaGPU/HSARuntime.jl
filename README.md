# ROCr.jl

*Julia interface to the ROCm platform runtime.*

This package provides a low-level interface for launching kernels from HSACO files.
To run kernels written in Julia, see the [AMDGPUnative.jl](https://github.com/JuliaGPU/AMDGPUnative.jl) package.

## Requirements

To build and run ROCr.jl, you need a functioning ROCm installation.
More specifically the following components are required:

* [ROCR](https://github.com/RadeonOpenCompute/ROCR-Runtime)
* [ROCT](https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface)
* Recent Linux kernel with AMDGPU and HSA enabled

Distro-specific setup instructions can be found in the [AMDGPUnative documentation](https://juliagpu.gitlab.io/AMDGPUnative.jl), as well as the [official ROCm installation guide](https://rocmdocs.amd.com/en/latest/Installation_Guide/Installation-Guide.html).

As a reminder, make sure `/dev/kfd` has a group other than `root` that you can add your user to.
It is recommended adding your user to the `video` group, and setting the ownership of `/dev/kfd` to `root:video` with 660 permissions.

Finally, make sure that the following libraries are in you `LD_LIBRARY_PATH`:
* libhsa-runtime64.so
* libhsakmt.so

Once everything is properly setup and configured, you should be able to `] build ROCr` successfully;
after that, if you have a supported GPU attached and enabled, `] test ROCr` should work exactly as you might expect.

