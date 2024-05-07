package main

import (
	"fmt"
	"math"
)

// Define the function
func sinFunction(x float64) float64 {
	return math.Sin(x)
}

// Define the integration function using trapezoidal rule
func integrate(f func(float64) float64, a, b float64, n int) float64 {
	h := (b - a) / float64(n)
	sum := 0.5 * (f(a) + f(b))
	for i := 1; i < n; i++ {
		x := a + float64(i)*h
		sum += f(x)
	}
	return h * sum
}

func main() {
	// Define the integration limits
	lowerLimit := -math.Pi
	upperLimit := 2.0 / 3.0 * math.Pi

	// Compute the definite integral using trapezoidal rule
	numIntervals := 10000 // Increase this for higher accuracy
	area := integrate(sinFunction, lowerLimit, upperLimit, numIntervals)

	fmt.Printf("Area between -π and 2/3π for sin(x) = %.6f\n", area)
}

