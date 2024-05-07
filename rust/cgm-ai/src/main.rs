use nalgebra::{DVector, MatrixMN};

// Function to perform matrix-vector multiplication: y = A*x
fn mat_vec_mult(A: &MatrixMN<f64, nalgebra::Dynamic, nalgebra::Dynamic>, x: &DVector<f64>) -> DVector<f64> {
    A * x
}

// Function to compute dot product of two vectors
fn dot_product(x: &DVector<f64>, y: &DVector<f64>) -> f64 {
    x.dot(y)
}

// Conjugate Gradient Method
fn conjugate_gradient(A: &MatrixMN<f64, nalgebra::Dynamic, nalgebra::Dynamic>, b: &DVector<f64>, tol: f64) -> DVector<f64> {
    let n = b.len();
    let mut x = DVector::zeros(n);
    let mut r = b.clone(); // Initial residual: r = b - A*x
    let mut p = r.clone(); // Initial search direction
    let mut Ap = DVector::zeros(n); // Placeholder for A*p

    let mut alpha;
    let mut beta;
    let mut rsold;
    let mut rsnew;

    // Compute initial residual norm
    rsold = dot_product(&r, &r);

    while rsold.sqrt() > tol {
        // Matrix-vector multiplication: Ap = A*p
        Ap = mat_vec_mult(A, &p);

        // Compute alpha
        alpha = rsold / dot_product(&p, &Ap);

        // Update solution: x = x + alpha*p
        x += alpha * &p;

        // Update residual: r = r - alpha*Ap
        r -= alpha * &Ap;

        // Compute new residual norm
        rsnew = dot_product(&r, &r);

        // Compute beta
        beta = rsnew / rsold;

        // Update search direction: p = r + beta*p
        p = r.clone() + beta * &p;

        // Update rsold for next iteration
        rsold = rsnew;
    }

    x
}

fn main() {
    // Example matrix A and vector b
    let A = MatrixMN::<f64, nalgebra::Dynamic, nalgebra::Dynamic>::from_row_slice(2, 2, &[4.0, 1.0, 1.0, 3.0]);
    let b = DVector::<f64>::from_row_slice(&[1.0, 2.0]);

    // Tolerance for convergence
    let tol = 1e-6;

    // Solve Ax = b
    let x = conjugate_gradient(&A, &b, tol);

    // Print solution
    println!("Solution vector x:");
    println!("{}", x);
}

