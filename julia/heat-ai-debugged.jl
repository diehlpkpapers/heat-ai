@everywhere using Distributed
@everywhere using SharedArrays
# Add more workers

@everywhere begin
    # Parameters
    const L = 1.0          # Length of the rod
    const T = 0.5          # Total time
    const Nx = 100         # Number of grid points in space
    const Nt = 1           # Number of time steps
    const alpha = 0.01     # Thermal diffusivity
    const dx = L / Nx      # Spatial step size
    const dt = T / Nt      # Time step size
end

@everywhere function heat_eqn_step(u::SharedArray{Float64}, start::Int, stop::Int)
        new_u = copy(u)
        for i in start:stop
            new_u[i] = u[i] + alpha * dt / dx^2 * (u[i-1] - 2 * u[i] + u[i+1])
        end
        u = copy(new_u)
    end

# Initialize temperature distribution
u = SharedArray{Float64}(Nx+1)
start_index = Int(0.4 / dx)
end_index = Int(0.6 / dx)
u[start_index:end_index] .= 1.0  # Initial temperature profile (step function)

# Solve heat equation using finite differences in parallel
@sync begin
for _ in 1:Nt
    chunk_size = div(Nx, nworkers())
    for start in 2:chunk_size:Nx
        stop = min(start + chunk_size - 1, Nx)
        heat_eqn_step(u, start, stop)
    end
end
end

# Print final temperature distribution
println("Final Temperature Distribution:")
for (i, temp) in enumerate(u)
    println("Node $i: Temperature = $temp")
end

