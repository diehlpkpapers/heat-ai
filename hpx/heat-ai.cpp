#include <hpx/hpx_main.hpp>
#include <hpx/include/iostreams.hpp>
#include <vector>

// Parameters
const double L = 1.0;        // Length of the rod
const double T = 0.5;        // Total time
const int Nx = 100;          // Number of grid points in space
const int Nt = 1000;         // Number of time steps
const double ALPHA = 0.01;   // Thermal diffusivity
const double DX = L / Nx;    // Spatial step size
const double DT = T / Nt;    // Time step size

// Function to perform one time step of the finite difference scheme
void heatEqnStep(std::vector<double>& u, std::vector<double>& newU) {
    for (int i = 1; i < Nx; ++i) {
        newU[i] = u[i] + ALPHA * DT / (DX * DX) * (u[i-1] - 2 * u[i] + u[i+1]);
    }
}

int main() {
    // Initialize temperature arrays
    std::vector<double> u(Nx + 1, 0.0);
    int startIndex = int(0.4 / DX);
    int endIndex = int(0.6 / DX);
    for (int i = startIndex; i <= endIndex; ++i) {
        u[i] = 1.0; // Initial temperature profile (step function)
    }
    std::vector<double> newU(Nx + 1, 0.0);

    // Solve heat equation using finite differences
    for (int t = 0; t < Nt; ++t) {
        heatEqnStep(u, newU);
        u = newU;
    }

    // Print final temperature distribution
    hpx::cout << "Final Temperature Distribution:" << hpx::endl;
    for (int i = 0; i <= Nx; ++i) {
        hpx::cout << "Node " << i << ": Temperature = " << u[i] << hpx::endl;
    }

    return 0;
}

