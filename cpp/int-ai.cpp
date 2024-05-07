#include <iostream>
#include <cmath>

using namespace std;

// Define the function
double sin_function(double x) {
    return sin(x);
}

// Define the integration function using trapezoidal rule
double integrate(double (*f)(double), double a, double b, int n) {
    double h = (b - a) / n;
    double sum = 0.5 * (f(a) + f(b));
    for (int i = 1; i < n; ++i) {
        double x = a + i * h;
        sum += f(x);
    }
    return h * sum;
}

int main() {
    // Define the integration limits
    double lower_limit = -M_PI;
    double upper_limit = 2.0/3.0 * M_PI;

    // Compute the definite integral using trapezoidal rule
    int num_intervals = 10000; // Increase this for higher accuracy
    double area = integrate(sin_function, lower_limit, upper_limit, num_intervals);

    cout << "Area between -π and 2/3π for sin(x) = " << area << endl;

    return 0;
}
