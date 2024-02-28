#include <iostream>
#include <Kokkos_Core.hpp>

// Parameters
const double L = 1.0;        // Length of the rod
const double T = 0.5;        // Total time
const int Nx = 100;          // Number of grid points in space
const int Nt = 1000;         // Number of time steps
const double ALPHA = 0.01;   // Thermal diffusivity
const double DX = L / Nx;    // Spatial step size
const double DT = T / Nt;    // Time step size

// Function to perform one time step of the finite difference scheme
struct HeatEqnStepFunctor {
    double* u;
    double* newU;
    HeatEqnStepFunctor(double* u_, double* newU_) : u(u_), newU(newU_) {}

    KOKKOS_INLINE_FUNCTION
    void operator()(const int i) const {
        newU[i] = u[i] + ALPHA * DT / (DX * DX) * (u[i-1] - 2 * u[i] + u[i+1]);
    }
};

int main() {
    // Initialize Kokkos
    Kokkos::initialize();

    // Initialize temperature arrays
    double* u = new double[Nx + 1];
    double* newU = new double[Nx + 1];
    int startIndex = int(0.4 / DX);
    int endIndex = int(0.6 / DX);
    for (int i = 0; i <= Nx; ++i) {
        if (i >= startIndex && i <= endIndex) {
            u[i] = 1.0; // Initial temperature profile (step function)
        } else {
            u[i] = 0.0;
        }
    }

    // Kokkos parallel execution
    Kokkos::parallel_for(Nx, HeatEqnStepFunctor(u, newU));
    Kokkos::fence();

    // Update temperature array
    for (int i = 0; i <= Nx; ++i) {
        u[i] = newU[i];
    }

    // Print final temperature distribution
    std::cout << "Final Temperature Distribution:" << std::endl;
    for (int i = 0; i <= Nx; ++i) {
        std::cout << "Node " << i << ": Temperature = " << u[i] << std::endl;
    }

    // Finalize Kokkos
    Kokkos::finalize();

    // Cleanup
    delete[] u;
    delete[] newU;

    return 0;
}

