# Parameters
L <- 1          # Length of the rod
T <- 0.5        # Total time
Nx <- 100       # Number of spatial grid points
Nt <- 1000      # Number of time steps
alpha <- 0.01   # Thermal diffusivity

dx <- L / (Nx - 1)
dt <- T / Nt
x <- seq(0, L, length.out = Nx)
u <- matrix(0, nrow = Nx, ncol = Nt)  # Temperature distribution

# Initial condition
u[,1] <- sin(pi * x)

# Boundary conditions
u[1,] <- 0     # Left boundary
u[Nx,] <- 0    # Right boundary

# Main loop
for (n in 1:(Nt-1)) {
    # Compute the temperature distribution at the next time step
    for (i in 2:(Nx-1)) {
        u[i,n+1] <- u[i,n] + alpha * dt / dx^2 * (u[i+1,n] - 2 * u[i,n] + u[i-1,n])
    }
}

# Plotting
library(animation)
saveGIF({
    for (n in seq(1, Nt, by = 10)) {
        plot(x, u[,n], type = 'l', ylim = c(-1, 1), main = paste("Time step =", n),
             xlab = "Position", ylab = "Temperature")
        Sys.sleep(0.1)  # Pause to show the plot
    }
}, interval = 0.1, movie.name = "heat_equation.gif")

