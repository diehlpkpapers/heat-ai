import numpy as np
import matplotlib.pyplot as plt
from joblib import Parallel, delayed

# Parameters
L = 1.0          # Length of the rod
T = 0.5          # Total time
Nx = 100         # Number of grid points in space
Nt = 1000        # Number of time steps
alpha = 0.01     # Thermal diffusivity
dx = L / Nx      # Spatial step size
dt = T / Nt      # Time step size
num_cores = 3    # Number of CPU cores

# Initialize temperature distribution
u = np.zeros(Nx+1)
u[int(0.4/dx):int(0.6/dx+1)] = 1.0  # Initial temperature profile (step function)

# Function to perform one time step of the finite difference scheme
def heat_eqn_step(u, alpha, dx, dt, start, end):
    new_u = np.copy(u)
    print(f"start:{start}, end:{end}")
    for i in range(start, end):
        print(f"i:{i}")
        print(f"u[i]:{u[i]}, u[i-1]:{u[i-1]}, u[i+1]:{u[i-1]}")
        new_u[i] = u[i] + alpha * dt / dx**2 * (u[i-1] - 2 * u[i] + u[i+1])
    return new_u

# Solve heat equation using finite differences in parallel
for _ in range(Nt):
    u = Parallel(n_jobs=num_cores)(
        delayed(heat_eqn_step)(u, alpha, dx, dt, 1, Nx) for _ in range(num_cores))

# Plot final temperature distribution
plt.figure(figsize=(8, 6))
plt.plot(np.linspace(0, L, Nx+1), u[0], label='Final')
plt.xlabel('Position')
plt.ylabel('Temperature')
plt.title('Final Temperature Distribution')
plt.grid(True)
plt.legend()
plt.show()

