import java.util.function.Function;

public class Main {

    // Define the function
    static double sinFunction(double x) {
        return Math.sin(x);
    }

    // Define the integration function using trapezoidal rule
    static double integrate(Function<Double, Double> f, double a, double b, int n) {
        double h = (b - a) / n;
        double sum = 0.5 * (f.apply(a) + f.apply(b));
        for (int i = 1; i < n; i++) {
            double x = a + i * h;
            sum += f.apply(x);
        }
        return h * sum;
    }

    public static void main(String[] args) {
        // Define the integration limits
        double lowerLimit = -Math.PI;
        double upperLimit = 2.0 / 3.0 * Math.PI;

        // Compute the definite integral using trapezoidal rule
        int numIntervals = 10000; // Increase this for higher accuracy
        double area = integrate(Main::sinFunction, lowerLimit, upperLimit, numIntervals);

        System.out.printf("Area between -π and 2/3π for sin(x) = %.6f%n", area);
    }
}

