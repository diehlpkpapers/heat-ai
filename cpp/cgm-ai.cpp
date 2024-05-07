#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

// Function to perform matrix-vector multiplication: y = A*x
void matVecMult(const vector<vector<double>>& A, const vector<double>& x, vector<double>& y) {
    int n = A.size();
    for (int i = 0; i < n; ++i) {
        y[i] = 0.0;
        for (int j = 0; j < n; ++j) {
            y[i] += A[i][j] * x[j];
        }
    }
}

// Function to perform vector addition: result = a*x + y
void vecAdd(const double& a, const vector<double>& x, const vector<double>& y, vector<double>& result) {
    int n = x.size();
    for (int i = 0; i < n; ++i) {
        result[i] = a * x[i] + y[i];
    }
}

// Function to compute dot product of two vectors
double dotProduct(const vector<double>& x, const vector<double>& y) {
    int n = x.size();
    double result = 0.0;
    for (int i = 0; i < n; ++i) {
        result += x[i] * y[i];
    }
    return result;
}

// Conjugate Gradient Method
vector<double> conjugateGradient(const vector<vector<double>>& A, const vector<double>& b, double tol = 1e-6) {
    int n = A.size();
    vector<double> x(n, 0.0); // Initial guess
    vector<double> r = b;     // Initial residual: r = b - A*x
    vector<double> p = r;     // Initial search direction
    vector<double> Ap(n, 0.0); // Placeholder for A*p

    double alpha, beta, rsold, rsnew;

    // Compute initial residual norm
    rsold = dotProduct(r, r);

    while (sqrt(rsold) > tol) {
        matVecMult(A, p, Ap);
        alpha = rsold / dotProduct(p, Ap);
        vecAdd(alpha, p, x, x);
        vecAdd(-alpha, Ap, r, r);
        rsnew = dotProduct(r, r);
        beta = rsnew / rsold;
        vecAdd(beta, p, r, p);
        rsold = rsnew;
    }

    return x;
}

int main() {
    // Example matrix A and vector b
    vector<vector<double>> A = {{4, 1}, {1, 3}};
    vector<double> b = {1, 2};

    // Solve Ax = b
    vector<double> x = conjugateGradient(A, b);

    // Print solution
    cout << "Solution vector x:" << endl;
    for (size_t i = 0; i < x.size(); ++i) {
        cout << "x[" << i << "] = " << x[i] << endl;
    }

    return 0;
}

