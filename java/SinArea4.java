public class SinArea4 {
    public static void main(String[] args) {
        double a = -Math.PI;      // Lower limit of integration
        double b = 2 * Math.PI / 3; // Upper limit of integration
        int n = 10000;            // Number of intervals

        double area = trapezoidalRule(a, b, n);
        System.out.printf("The total area between sin(x) and the x-axis from -pi to 2/3*pi is: %.4f\n", area);
    }

    public static double trapezoidalRule(double a, double b, int n) {
        double h = (b - a) / n; // Interval size
        double area = 0.0;
        for (int i = 0; i < n; i++) {
            double x1 = a + i * h;
            double x2 = x1 + h;
            area += 0.5 * h * (Math.abs(Math.sin(x1)) + Math.abs(Math.sin(x2)));
        }
        return area;
    }
}
