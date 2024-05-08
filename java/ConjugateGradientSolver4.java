public class ConjugateGradientSolver4 {
    public static void main(String[] args) {
        // Define a symmetric positive definite matrix A and vector b
        double[][] A = {
            {4, 1, 0},
            {1, 3, -1},
            {0, -1, 2}
        };
        double[] b = {1, 2, 3};
        double[] x0 = new double[b.length]; // Initial guess (zero vector)

        double[] x = conjugateGradient(A, b, x0, 1e-10); // Solve the system

        // Display the solution
        System.out.println("Solution x:");
        for (double v : x) {
            System.out.printf("%.5f ", v);
        }
        System.out.println();

        // Validate the solution by multiplying A * x and comparing with b
        double[] Ax = matrixVectorMultiply(A, x);
        System.out.println("Computed A*x:");
        for (double v : Ax) {
            System.out.printf("%.5f ", v);
        }
        System.out.println();
    }

    public static double[] conjugateGradient(double[][] A, double[] b, double[] x, double tol) {
        int n = b.length;
        double[] r = vectorSubtract(b, matrixVectorMultiply(A, x));
        double[] p = r.clone();
        double rsold = dotProduct(r, r);

        for (int i = 0; i < n; i++) {
            double[] Ap = matrixVectorMultiply(A, p);
            double alpha = rsold / dotProduct(p, Ap);
            x = vectorAdd(x, scalarMultiply(p, alpha));
            double[] r_new = vectorSubtract(r, scalarMultiply(Ap, alpha));
            double rsnew = dotProduct(r_new, r_new);

            if (Math.sqrt(rsnew) < tol) {
                break;
            }

            p = vectorAdd(r_new, scalarMultiply(p, rsnew / rsold));
            r = r_new;
            rsold = rsnew;
        }
        return x;
    }

    private static double[] matrixVectorMultiply(double[][] matrix, double[] vector) {
        double[] result = new double[vector.length];
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < vector.length; j++) {
                result[i] += matrix[i][j] * vector[j];
            }
        }
        return result;
    }

    private static double[] vectorAdd(double[] v1, double[] v2) {
        double[] result = new double[v1.length];
        for (int i = 0; i < v1.length; i++) {
            result[i] = v1[i] + v2[i];
        }
        return result;
    }

    private static double[] vectorSubtract(double[] v1, double[] v2) {
        double[] result = new double[v1.length];
        for (int i = 0; i < v1.length; i++) {
            result[i] = v1[i] - v2[i];
        }
        return result;
    }

    private static double[] scalarMultiply(double[] v, double scalar) {
        double[] result = new double[v.length];
        for (int i = 0; i < v.length; i++) {
            result[i] = v[i] * scalar;
        }
        return result;
    }

    private static double dotProduct(double[] v1, double[] v2) {
        double sum = 0;
        for (int i = 0; i < v1.length; i++) {
            sum += v1[i] * v2[i];
        }
        return sum;
    }
}
