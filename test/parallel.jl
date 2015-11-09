# This file is a part of Julia. License is MIT: http://julialang.org/license

# Run the parallel test outside of the main driver, since it runs off its own
# set of workers.

cmd = `$(Base.julia_cmd()) --check-bounds=yes --depwarn=error parallel_exec.jl`
if !success(pipeline(cmd; stdout=STDOUT, stderr=STDERR)) && ccall(:jl_running_on_valgrind,Cint,()) == 0
    error("Parallel test failed, cmd : $cmd")
end
