package main

import (
    "fmt"
    "math"
)

// TrapezoidalRule computes the integral of a function f between a and b using n intervals
func TrapezoidalRule(f func(float64) float64, a, b float64, n int) float64 {
    dx := (b - a) / float64(n)
    sum := 0.0
    x := a
    for i := 0; i < n; i++ {
        sum += (f(x) + f(x+dx)) / 2 * dx
        x += dx
    }
    return sum
}

// AbsSin is the function |sin(x)|
func AbsSin(x float64) float64 {
    return math.Abs(math.Sin(x))
}

func main() {
    // Integration limits
    a := -math.Pi
    b := 2.0 / 3.0 * math.Pi
    n := 10000  // Number of intervals

    // Compute the area using the Trapezoidal Rule
    area := TrapezoidalRule(AbsSin, a, b, n)

    // Print the computed area
    fmt.Printf("The total area between sin(x) and the x-axis from -pi to 2/3*pi is: %f\n", area)
}
