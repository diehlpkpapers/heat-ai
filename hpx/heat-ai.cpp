//  Copyright (c) 2024 AUTHORS
//
//  SPDX-License-Identifier: BSL-1.0
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#include <hpx/hpx_main.hpp>
#include <iostream>
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
    std::cout << "Final Temperature Distribution:" << std::endl;
    for (int i = 0; i <= Nx; ++i) {
        std::cout << "Node " << i << ": Temperature = " << u[i] << std::endl;
    }

    return 0;
}

