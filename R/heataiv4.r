# Parameters
L <- 10                # Length of the rod
T <- 2                 # Total time
Nx <- 100              # Number of spatial points
Nt <- 500              # Number of time points
alpha <- 0.01          # Thermal diffusivity of the rod

dx <- L / (Nx - 1)     # Spatial step size
dt <- T / Nt           # Time step size
x <- seq(0, L, length.out = Nx)  # Spatial grid

# Initial condition: temperature distribution
u <- sin(pi * x / L)

# Boundary conditions: u(0,t) = u(L,t) = 0
u[1] <- 0
u[Nx] <- 0

# Coefficient in the scheme
r <- alpha * dt / dx^2

library(parallel)

# Setting up the parallel backend
no_cores <- detectCores() - 1  # leave one core free for system processes
cl <- makeCluster(no_cores)
clusterExport(cl, list("u", "Nx", "r"))

# Time-stepping loop
for (t in 1:Nt) {
  # Parallel computation of the new temperature array
  u_new <- parLapply(cl, 2:(Nx-1), function(i) {
    u[i] + r * (u[i+1] - 2*u[i] + u[i-1])
  })

  # Update the solution
  u <- c(0, unlist(u_new), 0)  # reapply boundary conditions
}

# Stop the parallel cluster
stopCluster(cl)

plot(x, u, type = 'l', main = 'Temperature distribution along the rod', xlab = 'Position', ylab = 'Temperature')
