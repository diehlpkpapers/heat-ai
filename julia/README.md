### Runtime 

```bash
Unhandled Task ERROR: On worker 2:
UndefVarError: `u` not defined
Stacktrace:
 [1] macro expansion
   @ /work/diehlpk/heat-ai/julia/heat-ai.jl:39 [inlined]
 [2] #1
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/macros.jl:303
 [3] #178
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/macros.jl:83
 [4] #invokelatest#2
   @ ./essentials.jl:892 [inlined]
 [5] invokelatest
   @ ./essentials.jl:889
 [6] #107
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:283
 [7] run_work_thunk
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:70
 [8] run_work_thunk
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:79
 [9] #100
   @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:88

...and 3 more exceptions.

Stacktrace:
 [1] sync_end(c::Channel{Any})
   @ Base ./task.jl:448
 [2] macro expansion
   @ ./task.jl:480 [inlined]
 [3] (::Distributed.var"#177#179"{var"#1#2", UnitRange{Int64}})()
   @ Distributed ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/macros.jl:278
```

```bash
 julia heat-ai-v4.jl
ERROR: LoadError: On worker 2:
KeyError: key SharedArrays [1a1011a3-84de-559e-8e89-a11a2f7dc383] not found
Stacktrace:
  [1] getindex
    @ ./dict.jl:498 [inlined]
  [2] macro expansion
    @ ./lock.jl:267 [inlined]
  [3] root_module
    @ ./loading.jl:1878
  [4] deserialize_module
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:994
  [5] handle_deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:896
  [6] deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:814
  [7] deserialize_datatype
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:1398
  [8] handle_deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:867
  [9] deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:814
 [10] handle_deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:874
 [11] deserialize
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Serialization/src/Serialization.jl:814 [inlined]
 [12] deserialize_msg
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/messages.jl:87
 [13] #invokelatest#2
    @ ./essentials.jl:892 [inlined]
 [14] invokelatest
    @ ./essentials.jl:889 [inlined]
 [15] message_handler_loop
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:176
 [16] process_tcp_streams
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:133
 [17] #103
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/process_messages.jl:121
Stacktrace:
  [1] remotecall_fetch(::Function, ::Distributed.Worker, ::Distributed.RRID, ::Vararg{Any}; kwargs::@Kwargs{})
    @ Distributed ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/remotecall.jl:465
  [2] remotecall_fetch(::Function, ::Distributed.Worker, ::Distributed.RRID, ::Vararg{Any})
    @ Distributed ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/remotecall.jl:454
  [3] remotecall_fetch
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/remotecall.jl:492 [inlined]
  [4] call_on_owner
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/remotecall.jl:565 [inlined]
  [5] wait(r::Future)
    @ Distributed ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/Distributed/src/remotecall.jl:586
  [6] SharedVector{Float64}(dims::Tuple{Int64}; init::Bool, pids::Vector{Int64})
    @ SharedArrays ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/SharedArrays/src/SharedArrays.jl:137
  [7] SharedArray
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/SharedArrays/src/SharedArrays.jl:104 [inlined]
  [8] SharedArray
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/SharedArrays/src/SharedArrays.jl:161 [inlined]
  [9] SharedArray
    @ ~/.julia/juliaup/julia-1.10.3+0.x64.linux.gnu/share/julia/stdlib/v1.10/SharedArrays/src/SharedArrays.jl:167 [inlined]
 [10] solve_heat_equation(nx::Int64, nt::Int64, alpha::Float64, L::Float64, dt::Float64)
    @ Main /work/diehlpk/heat-ai/julia/heat-ai-v4.jl:21
 [11] top-level scope
    @ /work/diehlpk/heat-ai/julia/heat-ai-v4.jl:53
in expression starting at /work/diehlpk/heat-ai/julia/heat-ai-v4.jl:53
```

```bash
julia cgm-ai4.jl
ERROR: LoadError: UndefVarError: `dot` not defined
Stacktrace:
 [1] conjugateGradient(A::Matrix{Float64}, b::Vector{Float64}; tol::Float64, maxIter::Int64)
   @ Main /work/diehlpk/heat-ai/julia/cgm-ai4.jl:6
 [2] conjugateGradient(A::Matrix{Float64}, b::Vector{Float64})
   @ Main /work/diehlpk/heat-ai/julia/cgm-ai4.jl:1
 [3] top-level scope
   @ /work/diehlpk/heat-ai/julia/cgm-ai4.jl:28
in expression starting at /work/diehlpk/heat-ai/julia/cgm-ai4.jl:28
```
