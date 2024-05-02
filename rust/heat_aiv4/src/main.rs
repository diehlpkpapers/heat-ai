use rayon::prelude::*;

fn main() {
    let l = 10.0;         // Length of the rod
    let t = 2.0;          // Total time
    let nx = 100;         // Number of spatial points
    let nt = 500;         // Number of time points
    let alpha = 0.01;     // Thermal diffusivity

    let dx = l / (nx as f64 - 1.0);  // Spatial step size
    let dt = t / nt as f64;          // Time step size
    let r = alpha * dt / (dx * dx);  // Coefficient for the scheme

    let mut u: Vec<f64> = (0..nx).map(|i| (i as f64 * dx).sin()).collect();

    // Enforce boundary conditions
    u[0] = 0.0;
    u[nx - 1] = 0.0;

    for _ in 0..nt {
        let u_clone = u.clone();
        u.par_iter_mut().enumerate().for_each(|(i, u_i)| {
            if i != 0 && i != nx - 1 {
                *u_i = u_clone[i] + r * (u_clone[i + 1] - 2.0 * u_clone[i] + u_clone[i - 1]);
            }
        });

        // Enforce boundary conditions
        u[0] = 0.0;
        u[nx - 1] = 0.0;
    }

    // Output the final temperature distribution
    for (i, &temp) in u.iter().enumerate() {
        println!("x = {:.2}, u = {:.5}", i as f64 * dx, temp);
    }
}
