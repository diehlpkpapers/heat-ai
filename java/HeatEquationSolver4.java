import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class HeatEquationSolver4 {

    // Parameters
    private static final int L = 10;           // Length of the rod
    private static final int Nx = 100;         // Number of spatial points
    private static final int Nt = 500;         // Number of time points
    private static final double T = 2.0;       // Total time
    private static final double alpha = 0.01;  // Thermal diffusivity

    private static final double dx = L / (double) (Nx - 1);  // Spatial step size
    private static final double dt = T / (double) Nt;        // Time step size
    private static final double r = alpha * dt / (dx * dx);  // Coefficient

    private static double[] u = new double[Nx];  // Temperature array

    public static void main(String[] args) {
        new HeatEquationSolver4().solve();
    }

    public void solve() {
        // Initial condition
        for (int i = 0; i < Nx; i++) {
            u[i] = Math.sin(Math.PI * i * dx / L);
        }

        // Boundary conditions
        u[0] = 0.0;
        u[Nx - 1] = 0.0;

        // Create a thread pool
        ExecutorService executor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());

        // Time-stepping loop
        for (int t = 0; t < Nt; t++) {
            double[] u_new = new double[Nx];
            System.arraycopy(u, 0, u_new, 0, Nx);  // Copy u into u_new

            for (int i = 1; i < Nx - 1; i++) {
                int finalI = i;
                executor.submit(() -> {
                    u_new[finalI] = u[finalI] + r * (u[finalI + 1] - 2 * u[finalI] + u[finalI - 1]);
                });
            }

            try {
                executor.awaitTermination(1, TimeUnit.MILLISECONDS);  // Wait for tasks to finish
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            // Update the solution
            u = u_new;
        }

        // Shutdown the executor
        executor.shutdown();

        // Output the final distribution (optional)
        for (double temp : u) {
            System.out.printf("%.5f ", temp);
        }
        System.out.println();
    }
}
