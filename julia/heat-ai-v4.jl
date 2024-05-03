#  Copyright (c) 2024 AUTHORS
#
#  SPDX-License-Identifier: BSL-1.0
#  Distributed under the Boost Software License, Version 1.0. (See accompanying
#  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
using Distributed
using SharedArrays

# Add worker processes for parallel computation
addprocs(4) # Adjust the number of processes based on your system

@everywhere begin
    # Function to update the heat equation
    function update(u, alpha, dx, dt, nx, start_idx, end_idx)
        u_new = copy(u)
        for i in start_idx+1:end_idx-1
            u_new[i] = u[i] + alpha*dt/dx^2 * (u[i-1] - 2*u[i] + u[i+1])
        end
        return u_new
    end
end

# Main function to solve the heat equation
function solve_heat_equation(nx, nt, alpha, L, dt)
    dx = L/(nx-1)
    u = SharedArray{Float64}(nx)
    # Initial condition: sine wave
    for i in 1:nx
        u[i] = sin(pi*(i-1)*dx)
    end

    # Divide the domain among the available workers
    divs = [round(Int, l) for l in range(1, stop=nx, length=nworkers()+1)]
    
    for t in 1:nt
        # Parallel update
        futures = [@spawnat w update(u, alpha, dx, dt, nx, divs[w], divs[w+1]) for w in 1:nworkers()]
        u_new = reduce((x,y) -> x .+ y, fetch.(futures)) / nworkers()
        
        # Boundary conditions
        u_new[1] = 0.0
        u_new[end] = 0.0

        copyto!(u, u_new)
    end
    
    return u
end

# Parameters
nx = 100
nt = 1000
alpha = 0.01
L = 1.0
dt = 0.01

# Solve the heat equation
u_final = solve_heat_equation(nx, nt, alpha, L, dt)

# Optionally, plot or print the final solution
using Plots
plot(u_final, legend=false)
