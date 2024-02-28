extern crate rayon;

use rayon::prelude::*;

// Parameters
const L: f64 = 1.0;         // Length of the rod
const T: f64 = 0.5;         // Total time
const NX: usize = 100;      // Number of grid points in space
const NT: usize = 1000;     // Number of time steps
const ALPHA: f64 = 0.01;    // Thermal diffusivity
const DX: f64 = L / NX as f64;  // Spatial step size
const DT: f64 = T / NT as f64;  // Time step size

// Function to perform one time step of the finite difference scheme
fn heat_eqn_step(u: &mut Vec<f64>, start: usize, end: usize) {
    let mut new_u = u.clone();
    for i in start..end {
        new_u[i] = u[i] + ALPHA * DT / DX.powi(2) * (u[i-1] - 2.0 * u[i] + u[i+1]);
    }
    *u = new_u;
}

fn main() {
    // Initialize temperature distribution
    let mut u = vec![0.0; NX + 1];
    let start_index = (0.4 / DX) as usize;
    let end_index = (0.6 / DX) as usize;
    u[start_index..=end_index].iter_mut().for_each(|x| *x = 1.0); // Initial temperature profile (step function)

    // Solve heat equation using finite differences in parallel
    for _ in 0..NT {
        let chunk_size = NX / rayon::current_num_threads();
        u.par_chunks_mut(chunk_size)
            .enumerate()
            .for_each(|(idx, chunk)| {
                let start = idx * chunk_size;
                let end = start + chunk_size;
                heat_eqn_step(chunk, start, end);
            });
    }

    // Print final temperature distribution
    println!("Final Temperature Distribution:");
    for (i, temp) in u.iter().enumerate() {
        println!("Node {}: Temperature = {}", i, temp);
    }
}

