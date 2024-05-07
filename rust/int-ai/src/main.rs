extern crate special;

use special::Gamma;
use std::f64::consts::PI;

// Define the function
fn sin_function(x: f64) -> f64 {
    x.sin()
}

// Define the integration function using trapezoidal rule
fn integrate(f: fn(f64) -> f64, a: f64, b: f64, n: usize) -> f64 {
    let h = (b - a) / n as f64;
    let mut sum = 0.5 * (f(a) + f(b));
    for i in 1..n {
        let x = a + i as f64 * h;
        sum += f(x);
    }
    h * sum
}

fn main() {
    // Define the integration limits
    let lower_limit = -PI;
    let upper_limit = 2.0 / 3.0 * PI;

    // Compute the definite integral using trapezoidal rule
    let num_intervals = 10000; // Increase this for higher accuracy
    let area = integrate(sin_function, lower_limit, upper_limit, num_intervals);

    println!("Area between -π and 2/3π for sin(x) = {:.6}", area);
}

