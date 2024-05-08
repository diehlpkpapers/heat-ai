import java.util.Arrays;

public class ConjugateGradientSolver {

    // Function to perform matrix-vector multiplication: y = A*x
    private static double[] matVecMult(double[][] A, double[] x) {
        int n = x.length;
        double[] y = new double[n];

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                y[i] += A[i][j] * x[j];
            }
        }

        return y;
    }

    // Function to compute dot product of two vectors
    private static double dotProduct(double[] x, double[] y) {
        int n = x.length;
        double dot = 0.0;

        for (int i = 0; i < n; i++) {
            dot += x[i] * y[i];
        }

        return dot;
    }

    // Conjugate Gradient Method
    public static double[] conjugateGradient(double[][] A, double[] b, double tol) {
        int n = b.length;
        double[] x = new double[n];
        double[] r = Arrays.copyOf(b, n); // Initial residual: r = b - A*x
        double[] p = Arrays.copyOf(r, n); // Initial search direction
        double[] Ap = new double[n]; // Placeholder for A*p

        double alpha, beta, rsold, rsnew;

        // Compute initial residual norm
        rsold = dotProduct(r, r);

        while (Math.sqrt(rsold) > tol) {
            // Matrix-vector multiplication: Ap = A*p
            Ap = matVecMult(A, p);

            // Compute alpha
            alpha = rsold / dotProduct(p, Ap);

            // Update solution: x = x + alpha*p
            for (int i = 0; i < n; i++) {
                x[i] += alpha * p[i];
            }

            // Update residual: r = r - alpha*Ap
            for (int i = 0; i < n; i++) {
                r[i] -= alpha * Ap[i];
            }

            // Compute new residual norm
            rsnew = dotProduct(r, r);

            // Compute beta
            beta = rsnew / rsold;

            // Update search direction: p = r + beta*p
            for (int i = 0; i < n; i++) {
                p[i] = r[i] + beta * p[i];
            }

            // Update rsold for next iteration
            rsold = rsnew;
        }

        return x;
    }

    public static void main(String[] args) {
        // Example matrix A and vector b
        double[][] A = {{4, 1}, {1, 3}};
        double[] b = {1, 2};

        // Tolerance for convergence
        double tol = 1e-6;

        // Solve Ax = b
        double[] x = conjugateGradient(A, b, tol);

        // Print solution
        System.out.println("Solution vector x:");
        for (int i = 0; i < x.length; i++) {
            System.out.printf("x[%d] = %.6f\n", i, x[i]);
        }
    }
}

