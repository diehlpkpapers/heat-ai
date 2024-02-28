#include <Kokkos_Core.hpp>
#include <cmath>
#include <iostream>

// Define the update kernel for the heat equation
struct UpdateTemperature {
    Kokkos::View<double*> u;
    Kokkos::View<double*> u_new;
    double alpha, dx, dt;

    UpdateTemperature(Kokkos::View<double*> u, Kokkos::View<double*> u_new, double alpha, double dx, double dt)
    : u(u), u_new(u_new), alpha(alpha), dx(dx), dt(dt) {}

    KOKKOS_INLINE_FUNCTION
    void operator()(const int i) const {
        if (i > 0 && i < u.extent(0)-1) {
            u_new(i) = u(i) + (alpha * dt / (dx * dx)) * (u(i-1) - 2*u(i) + u(i+1));
        }
    }
};

int main(int argc, char* argv[]) {
    Kokkos::initialize(argc, argv);
    {
        // Parameters
        const int N = 100; // Number of spatial points
        const double L = 1.0; // Length of the rod
        const double dx = L / (N - 1);
        const double dt = 0.01; // Time step
        const double alpha = 0.01; // Thermal diffusivity
        const int steps = 100; // Number of time steps

        // Allocate and initialize temperature arrays
        Kokkos::View<double*> u("u", N);
        Kokkos::View<double*> u_new("u_new", N);
        Kokkos::parallel_for("initialize_u", N, KOKKOS_LAMBDA(int i) {
            u(i) = sin(M_PI * i * dx); // Initial condition
        });

        // Time-stepping loop
        for (int t = 0; t < steps; ++t) {
            Kokkos::parallel_for("update_temperature", N, UpdateTemperature(u, u_new, alpha, dx, dt));
            Kokkos::deep_copy(u, u_new); // Prepare for the next step
        }

        // Output the final state for verification (optional)
        auto u_host = Kokkos::create_mirror_view(u);
        Kokkos::deep_copy(u_host, u);
        for (int i = 0; i < N; ++i) {
            std::cout << "u[" << i << "] = " << u_host(i) << std::endl;
        }
    }
    Kokkos::finalize();
    return 0;
}
