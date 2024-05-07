package main

import (
	"fmt"
	"math"
)

// matVecMult performs matrix-vector multiplication: y = A*x
func matVecMult(A [][]float64, x []float64) []float64 {
	n := len(A)
	y := make([]float64, n)

	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			y[i] += A[i][j] * x[j]
		}
	}

	return y
}

// dotProduct computes the dot product of two vectors
func dotProduct(x, y []float64) float64 {
	n := len(x)
	dot := 0.0

	for i := 0; i < n; i++ {
		dot += x[i] * y[i]
	}

	return dot
}

// conjugateGradient solves Ax = b using the conjugate gradient method
func conjugateGradient(A [][]float64, b []float64, tol float64) []float64 {
	n := len(b)
	x := make([]float64, n)
	r := make([]float64, n)
	p := make([]float64, n)
	Ap := make([]float64, n)

	// Initial guess for x
	for i := 0; i < n; i++ {
		x[i] = 0.0
	}

	// Initial residual: r = b - A*x
	r = b

	// Initial search direction
	p = r

	// Compute initial residual norm
	rsold := dotProduct(r, r)

	// Conjugate gradient iterations
	for math.Sqrt(rsold) > tol {
		// Matrix-vector multiplication: Ap = A*p
		Ap = matVecMult(A, p)

		// Compute alpha
		alpha := rsold / dotProduct(p, Ap)

		// Update solution: x = x + alpha*p
		for i := 0; i < n; i++ {
			x[i] += alpha * p[i]
		}

		// Update residual: r = r - alpha*Ap
		for i := 0; i < n; i++ {
			r[i] -= alpha * Ap[i]
		}

		// Compute new residual norm
		rsnew := dotProduct(r, r)

		// Compute beta
		beta := rsnew / rsold

		// Update search direction: p = r + beta*p
		for i := 0; i < n; i++ {
			p[i] = r[i] + beta*p[i]
		}

		// Update rsold for next iteration
		rsold = rsnew
	}

	return x
}

func main() {
	// Example matrix A and vector b
	A := [][]float64{{4, 1}, {1, 3}}
	b := []float64{1, 2}

	// Tolerance for convergence
	tol := 1e-6

	// Solve Ax = b
	x := conjugateGradient(A, b, tol)

	// Print solution
	fmt.Println("Solution vector x:")
	for i, val := range x {
		fmt.Printf("x[%d] = %.6f\n", i, val)
	}
}

