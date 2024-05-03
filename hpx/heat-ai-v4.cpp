//  Copyright (c) 2024 AUTHORS
//
//  SPDX-License-Identifier: BSL-1.0
//  Distributed under the Boost Software License, Version 1.0. (See accompanying
//  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
#include <hpx/hpx_main.hpp>
#include <hpx/include/lcos.hpp>
#include <hpx/include/parallel_algorithm.hpp>
#include <hpx/include/util.hpp>
#include <vector>
#include <cmath>
#include <iostream>

const int Nx = 100; // Number of spatial steps
const int Nt = 1000; // Number of time steps
const double alpha = 0.01; // Thermal diffusivity
const double L = 1.0; // Length of the rod
const double dx = L / (Nx - 1);
const double dt = 0.01; // Time step
const double r = alpha * dt / (dx * dx);

std::vector<double> initialize() {
    std::vector<double> u(Nx);
    for (int i = 0; i < Nx; ++i) {
        u[i] = sin(M_PI * i * dx);
    }
    return u;
}

void update(std::vector<double>& u, const std::vector<double>& u_old) {
    hpx::for_loop(hpx::execution::par, 1, Nx-1, [&u, &u_old](int i) {
        u[i] = u_old[i] + r * (u_old[i-1] - 2.0 * u_old[i] + u_old[i+1]);
    });
}

int main() {
    auto u = initialize();
    std::vector<double> u_old(Nx);

    for (int t = 0; t < Nt; ++t) {
        std::copy(u.begin(), u.end(), u_old.begin());
        update(u, u_old);
        // Apply boundary conditions
        u[0] = u[Nx-1] = 0.0;
    }

    // Output or process the final temperature distribution in u
    for (int i = 0; i < Nx; ++i) {
        std::cout << "u[" << i << "] = " << u[i] << std::endl;
    }

    return 0;
}
