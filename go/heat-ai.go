package main

import (
	"fmt"
	"math"
	"sync"
)

const (
	L      = 1.0  // Length of the rod
	T      = 0.5  // Total time
	Nx     = 100  // Number of grid points in space
	Nt     = 1000 // Number of time steps
	Alpha  = 0.01 // Thermal diffusivity
	Dx     = L / Nx
	Dt     = T / Nt
	Worker = 4    // Number of workers
)

// Function to perform one time step of the finite difference scheme
func heatEqnStep(u, newU []float64, start, stop int, wg *sync.WaitGroup) {
	defer wg.Done()
	for i := start; i <= stop; i++ {
		newU[i] = u[i] + Alpha*Dt/(Dx*Dx)*(u[i-1]-2*u[i]+u[i+1])
	}
}

func main() {
	// Initialize temperature distribution
	u := make([]float64, Nx+1)
	startIndex := int(0.4 / Dx)
	endIndex := int(0.6 / Dx)
	for i := startIndex; i <= endIndex; i++ {
		u[i] = 1.0 // Initial temperature profile (step function)
	}

	// Solve heat equation using finite differences in parallel
	newU := make([]float64, Nx+1)
	wg := sync.WaitGroup{}
	wg.Add(Worker)
	for i := 0; i < Worker; i++ {
		start := i * (Nx + 1) / Worker
		stop := (i + 1) * (Nx + 1) / Worker
		go heatEqnStep(u, newU, start, stop-1, &wg)
	}
	wg.Wait()
	u = newU

	// Print final temperature distribution
	fmt.Println("Final Temperature Distribution:")
	for i, temp := range u {
		fmt.Printf("Node %d: Temperature = %f\n", i, temp)
	}
}

