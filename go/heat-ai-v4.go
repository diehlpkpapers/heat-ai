package main

import (
	"fmt"
	"math"
	"sync"
)

const (
	Nx    = 100   // Number of spatial steps
	Nt    = 1000  // Number of time steps
	alpha = 0.01  // Thermal diffusivity
	dx    = 1.0 / (Nx - 1)
	dt    = 0.01 // Time step
)

func main() {
	// Initialize temperature distribution
	u := make([]float64, Nx)
	for i := range u {
		u[i] = math.Sin(math.Pi * float64(i) * dx)
	}

	// Number of goroutines
	numGoroutines := 4
	chunkSize := Nx / numGoroutines

	var wg sync.WaitGroup
	wg.Add(numGoroutines)

	for t := 0; t < Nt; t++ {
		uNew := make([]float64, Nx)
		copy(uNew, u)

		for i := 0; i < numGoroutines; i++ {
			go func(i int) {
				defer wg.Done()
				start := i * chunkSize
				end := start + chunkSize
				if i == numGoroutines-1 {
					end = Nx
				}
				for j := start + 1; j < end-1; j++ {
					uNew[j] = u[j] + alpha*dt/(dx*dx)*(u[j-1]-2*u[j]+u[j+1])
				}
			}(i)
		}

		wg.Wait() // Wait for all goroutines to finish
		copy(u, uNew)
	}

	// Apply boundary conditions
	u[0], u[Nx-1] = 0, 0

	// Output or process the final temperature distribution in u
	for i, v := range u {
		fmt.Printf("u[%d] = %f\n", i, v)
	}
}
