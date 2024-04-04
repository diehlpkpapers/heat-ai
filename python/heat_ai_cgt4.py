import numpy as np
from multiprocessing import Pool

def update_segment(args):
    u, alpha, dx2, dt, start, end = args
    new_u = u.copy()
    for i in range(start, end):
        new_u[i] = u[i] + alpha * dt / dx2 * (u[i - 1] - 2 * u[i] + u[i + 1])
    return new_u[start:end]

def parallel_heat_equation(u0, alpha, L, T, Nx, Nt, num_workers):
    dx = L / Nx
    dt = T / Nt
    dx2 = dx**2
    u = np.zeros(Nx + 1)
    u[1:Nx] = u0[1:Nx]
    
    pool = Pool(processes=num_workers)
    segment_size = Nx // num_workers
    
    for n in range(Nt):
        tasks = []
        for i in range(num_workers):
            start = i * segment_size + 1
            end = start + segment_size
            if i == num_workers - 1:
                end = Nx  # Ensure the last segment goes to the boundary
            tasks.append((u, alpha, dx2, dt, start, end))
        
        results = pool.map(update_segment, tasks)
        
        # Combine the results
        for i, segment in enumerate(results):
            start = i * segment_size + 1
            end = start + len(segment)
            u[start:end] = segment
            
        # Apply boundary conditions (if any, modify as needed)
        u[0] = u[Nx] = 0  # For example, Dirichlet boundary conditions
        
    pool.close()
    pool.join()
    
    return u

# Example usage
L = 10  # Length of the rod
T = 1  # Total time
Nx = 100  # Number of spatial steps
Nt = 100  # Number of time steps
alpha = 0.01  # Thermal diffusivity
num_workers = 4  # Number of parallel workers

# Initial condition (e.g., u(x, 0) = sin(pi * x / L))
x = np.linspace(0, L, Nx + 1)
u0 = np.sin(np.pi * x / L)

# Solve the equation
u_final = parallel_heat_equation(u0, alpha, L, T, Nx, Nt, num_workers)

# u_final now contains the solution at T
# Plot final temperature distribution
plt.figure(figsize=(8, 6))
plt.plot(np.linspace(0, L, Nx+1), u_final, label='Final')
plt.xlabel('Position')
plt.ylabel('Temperature')
plt.title('Final Temperature Distribution')
plt.grid(True)
plt.legend()
plt.show()
