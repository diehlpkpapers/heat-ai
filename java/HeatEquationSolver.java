import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class HeatEquationSolver {

    // Parameters
    private static final double L = 1.0;       // Length of the rod
    private static final double T = 0.5;       // Total time
    private static final int Nx = 100;         // Number of grid points in space
    private static final int Nt = 1000;        // Number of time steps
    private static final double ALPHA = 0.01;  // Thermal diffusivity
    private static final double DX = L / Nx;   // Spatial step size
    private static final double DT = T / Nt;   // Time step size
    private static final int NUM_THREADS = 4;  // Number of threads

    // Function to perform one time step of the finite difference scheme
    private static void heatEqnStep(double[] u, int start, int end) {
        for (int i = start; i <= end; i++) {
            u[i] += ALPHA * DT / (DX * DX) * (u[i - 1] - 2 * u[i] + u[i + 1]);
        }
    }

    public static void main(String[] args) {
        // Initialize temperature distribution
        double[] u = new double[Nx + 1];
        int startIndex = (int) (0.4 / DX);
        int endIndex = (int) (0.6 / DX);
        for (int i = startIndex; i <= endIndex; i++) {
            u[i] = 1.0; // Initial temperature profile (step function)
        }

        // Create thread pool
        ExecutorService executor = Executors.newFixedThreadPool(NUM_THREADS);

        // Solve heat equation using finite differences in parallel
        for (int t = 0; t < Nt; t++) {
            int chunkSize = (Nx + 1) / NUM_THREADS;
            for (int i = 0; i < NUM_THREADS; i++) {
                int start = i * chunkSize;
                System.out.println("start:"+start);
                int end = (i == NUM_THREADS - 1) ? Nx : (i + 1) * chunkSize - 1;
                System.out.println("end:"+end);
                executor.execute(() -> heatEqnStep(u, start, end));
            }
        }

        // Shutdown thread pool
        executor.shutdown();

        // Print final temperature distribution
        System.out.println("Final Temperature Distribution:");
        for (int i = 0; i <= Nx; i++) {
            System.out.println("Node " + i + ": Temperature = " + u[i]);
        }
    }
}

