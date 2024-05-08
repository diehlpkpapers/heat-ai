#include <iostream>
#include <cmath>    // For sin() and M_PI

// Function to calculate f(x) = sin(x)
double f(double x) {
    return sin(x);
}

// Trapezoidal Rule Implementation
double trapezoidalRule(double a, double b, int n) {
    double h = (b - a) / n;  // Step size
    double area = 0.0;
    double x = a;

    // Sum area of each trapezoid
    for (int i = 0; i < n; ++i) {
        area += 0.5 * h * (f(x) + f(x + h));
        x += h;
    }

    return area;
}

// Function to compute the area under sin(x) between a and b, considering absolute values
double computeAbsoluteArea(double a, double b, int n) {
    double h = (b - a) / n;  // Step size
    double area = 0.0;
    double x = a;

    // Sum absolute areas under the curve
    for (int i = 0; i < n; ++i) {
        area += 0.5 * h * (fabs(f(x)) + fabs(f(x + h)));
        x += h;
    }

    return area;
}

int main() {
    double a = -M_PI;
    double b = 2.0 / 3.0 * M_PI;
    int n = 1000;  // Number of intervals (higher means more accuracy)

    double area = trapezoidalRule(a, b, n);
    double absArea = computeAbsoluteArea(a, b, n);

    std::cout << "Approximate integral of sin(x) from -pi to 2/3*pi: " << area << std::endl;
    std::cout << "Total area between sin(x) and the x-axis from -pi to 2/3*pi: " << absArea << std::endl;

    return 0;
}
