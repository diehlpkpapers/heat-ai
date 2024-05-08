#include <iostream>
#include <vector>
#include <cmath>

// Function to perform matrix-vector multiplication
std::vector<double> matVecMultiply(const std::vector<std::vector<double>>& A, const std::vector<double>& v) {
    std::vector<double> result(A.size(), 0.0);
    for (size_t i = 0; i < A.size(); ++i) {
        for (size_t j = 0; j < A[i].size(); ++j) {
            result[i] += A[i][j] * v[j];
        }
    }
    return result;
}

// Function to calculate the dot product of two vectors
double dotProduct(const std::vector<double>& v1, const std::vector<double>& v2) {
    double sum = 0.0;
    for (size_t i = 0; i < v1.size(); ++i) {
        sum += v1[i] * v2[i];
    }
    return sum;
}

// Function to subtract two vectors
std::vector<double> vectorSubtract(const std::vector<double>& v1, const std::vector<double>& v2) {
    std::vector<double> result(v1.size());
    for (size_t i = 0; i < v1.size(); ++i) {
        result[i] = v1[i] - v2[i];
    }
    return result;
}

// Function to add two vectors
std::vector<double> vectorAdd(const std::vector<double>& v1, const std::vector<double>& v2) {
    std::vector<double> result(v1.size());
    for (size_t i = 0; i < v1.size(); ++i) {
        result[i] = v1[i] + v2[i];
    }
    return result;
}

// Function to multiply vector by scalar
std::vector<double> scalarMultiply(double scalar, const std::vector<double>& v) {
    std::vector<double> result(v.size());
    for (size_t i = 0; i < v.size(); ++i) {
        result[i] = scalar * v[i];
    }
    return result;
}

// Conjugate Gradient Solver
void conjugateGradient(const std::vector<std::vector<double>>& A, const std::vector<double>& b, std::vector<double>& x) {
    int n = b.size();
    std::vector<double> r = vectorSubtract(b, matVecMultiply(A, x));
    std::vector<double> p = r;
    std::vector<double> r_old;
    double alpha, beta, rsold;

    rsold = dotProduct(r, r);
    
    for (int i = 0; i < n; i++) {
        std::vector<double> Ap = matVecMultiply(A, p);
        alpha = rsold / dotProduct(p, Ap);
        x = vectorAdd(x, scalarMultiply(alpha, p));
        r_old = r;
        r = vectorSubtract(r, scalarMultiply(alpha, Ap));

        if (sqrt(dotProduct(r, r)) < 1e-10)
            break;

        beta = dotProduct(r, r) / rsold;
        p = vectorAdd(r, scalarMultiply(beta, p));
        rsold = dotProduct(r, r);
    }
}

int main() {
    std::vector<std::vector<double>> A = {
        {4, 1, 0},
        {1, 3, -1},
        {0, -1, 2}
    };
    std::vector<double> b = {1, 2, 3};
    std::vector<double> x = {0, 0, 0};  // Initial guess

    conjugateGradient(A, b, x);

    std::cout << "Solution x: ";
    for (const auto& xi :
