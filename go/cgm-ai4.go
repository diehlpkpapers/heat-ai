package main

import (
    "fmt"
    "math"
)

// Matrix-vector multiplication
func matVecMul(A [][]float64, v []float64) []float64 {
    n := len(v)
    result := make([]float64, n)
    for i := 0; i < n; i++ {
        sum := 0.0
        for j := 0; j < n; j++ {
            sum += A[i][j] * v[j]
        }
        result[i] = sum
    }
    return result
}

// Dot product of two vectors
func dotProduct(v1, v2 []float64) float64 {
    sum := 0.0
    for i := range v1 {
        sum += v1[i] * v2[i]
    }
    return sum
}

// Vector addition v1 + v2
func vectorAdd(v1, v2 []float64) []float64 {
    result := make([]float64, len(v1))
    for i := range v1 {
        result[i] = v1[i] + v2[i]
    }
    return result
}

// Vector subtraction v1 - v2
func vectorSub(v1, v2 []float64) []float64 {
    result := make([]float64, len(v1))
    for i := range v1 {
        result[i] = v1[i] - v2[i]
    }
    return result
}

// Scalar-vector multiplication
func scalarVecMul(alpha float64, v []float64) []float64 {
    result := make([]float64, len(v))
    for i := range v {
        result[i] = alpha * v[i]
    }
    return result
}

// ConjugateGradient solves the system Ax = b for x using the Conjugate Gradient method
func ConjugateGradient(A [][]float64, b []float64, tol float64, maxIter int) []float64 {
    n := len(b)
    x := make([]float64, n) // Initial guess x0
    r := vectorSub(b, matVecMul(A, x))
    p := r
    rsOld := dotProduct(r, r)

    for i := 0; i < maxIter; i++ {
        Ap := matVecMul(A, p)
        alpha := rsOld / dotProduct(p, Ap)
        x = vectorAdd(x, scalarVecMul(alpha, p))
        rNew := vectorSub(r, scalarVecMul(alpha, Ap))
        rsNew := dotProduct(rNew, rNew)

        if math.Sqrt(rsNew) < tol {
            break
        }

        p = vectorAdd(rNew, scalarVecMul(rsNew/rsOld, p))
        r = rNew
        rsOld = rsNew
    }

    return x
}

func main() {
    A := [][]float64{
        {4, 1, 0},
        {1, 3, -1},
        {0, -1, 2},
    }
    b := []float64{1, 2, 3}
    tol := 1e-8
    maxIter := 1000
