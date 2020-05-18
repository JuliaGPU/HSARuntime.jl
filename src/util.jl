
### HSA Errors ###

export HSAError

struct HSAError <: Exception
    code::Status
end

"""
    description(err::HSAError)

Gets the string description of an error code.
"""
function description(err::HSAError)
    str_ref = Ref{Cstring}()
    HSA.status_string(err.code, str_ref)
    unsafe_string(str_ref[])
end

function Base.showerror(io::IO, err::HSAError)
    print(io, "HSA error (code #$(Int(err.code)), $(description(err)))")
end

Base.show(io::IO, err::HSAError) =
    print(io, "HSAError($(Int(err.code)), $(description(err)))")

function check(result)
    if result != HSA.STATUS_SUCCESS
        throw(HSAError(result))
    end
end

