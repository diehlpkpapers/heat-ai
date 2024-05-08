use std::f64::consts::PI;

/// Function to compute the trapezoidal rule for numerical integration
fn trapezoidal_rule<F>(f: F, a: f64, b: f64, n: usize) -> f64
where
    F: Fn(f64) -> f64,
{
    let h = (b - a) / n as f64;
    let mut area = 0.0;
    let mut x = a;

    for _ in 0..n {
        area += (f(x) + f(x + h)) / 2.0 * h;
        x += h;
    }

    area
}

/// Absolute value of sin(x)
fn abs_sin(x: f64) -> f64 {
    x.sin().abs()
}

fn main() {
    let a = -PI;
    let b = 2.0 / 3.0 * PI;
    let n = 10000; // Number of intervals for better accuracy

    // Compute the area using the trapezoidal rule
    let area = trapezoidal_rule(abs_sin, a, b, n);

    // Print the computed area
    println!("The total area between sin(x) and the x-axis from -pi to 2/3pi is: {:.4}", area);
}
