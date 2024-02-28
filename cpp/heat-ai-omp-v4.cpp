#include <vector>
#include <iostream>
#include <cmath>
#include <omp.h>

int main() {
    const int Nx = 100; // Number of spatial steps
    const int Nt = 1000; // Number of time steps
    const double L = 10.0; // Length of the rod
    const double alpha = 0.01; // Thermal diffusivity
    const double dx = L / Nx;
    const double dt = 0.01; // Time step
    const double r = alpha * dt / (dx * dx);

    std::vector<double> u(Nx, 0); // Temperature distribution
    std::vector<double> u_new(Nx, 0); // Updated temperature distribution

    // Initial condition: e.g., u(x,0) = sin(pi * x / L)
    for(int i = 0; i < Nx; ++i) {
        u[i] = std::sin(M_PI * i * dx / L);
    }

    // Boundary conditions
    u[0] = u[Nx-1] = 0.0;
    u_new[0] = u_new[Nx-1] = 0.0;

    // Time-stepping loop
    for(int t = 0; t < Nt; ++t) {
        #pragma omp parallel for default(none) shared(u, u_new, Nx, r)
        for(int i = 1; i < Nx-1; ++i) {
            u_new[i] = u[i] + r * (u[i-1] - 2*u[i] + u[i+1]);
        }

        // Swap pointers for the next iteration
        std::swap(u, u_new);
    }

    // Output the final temperature distribution
    for(int i = 0; i < Nx; ++i) {
        std::cout << "u[" << i << "] = " << u[i] << std::endl;
    }

    return 0;
}
