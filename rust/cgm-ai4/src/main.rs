use std::ops::{Add, Mul, Sub};

/// Represents a vector of floating point numbers
type Vector = Vec<f64>;

/// Represents a matrix, which is a vector of vectors
type Matrix = Vec<Vector>;

/// Dot product of two vectors
fn dot_product(x: &Vector, y: &Vector) -> f64 {
    x.iter().zip(y.iter()).map(|(xi, yi)| xi * yi).sum()
}

/// Matrix-vector multiplication
fn mat_vec_mul(mat: &Matrix, vec: &Vector) -> Vector {
    mat.iter()
        .map(|row| dot_product(row, vec))
        .collect()
}

/// Scalar-vector multiplication
fn scalar_vec_mul(scalar: f64, vec: &Vector) -> Vector {
    vec.iter().map(|&v| scalar * v).collect()
}

/// Vector addition
fn vec_add(v1: &Vector, v2: &Vector) -> Vector {
    v1.iter().zip(v2.iter()).map(|(a, b)| a + b).collect()
}

/// Vector subtraction
fn vec_sub(v1: &Vector, v2: &Vector) -> Vector {
    v1.iter().zip(v2.iter()).map(|(a, b)| a - b).collect()
}

/// Conjugate Gradient Solver
fn conjugate_gradient(A: &Matrix, b: &Vector, tol: f64) -> Vector {
    let mut x = vec![0.0; b.len()];
    let mut r = vec_sub(b, &mat_vec_mul(A, &x));
    let mut p = r.clone();
    let mut rsold = dot_product(&r, &r);

    for _ in 0..b.len() {
        let Ap = mat_vec_mul(A, &p);
        let alpha = rsold / dot_product(&p, &Ap);
        x = vec_add(&x, &scalar_vec_mul(alpha, &p));
        let r_new = vec_sub(&r, &scalar_vec_mul(alpha, &Ap));
        let rsnew = dot_product(&r_new, &r_new);

        if rsnew.sqrt() < tol {
            break;
        }

        p = vec_add(&r_new, &scalar_vec_mul(rsnew / rsold, &p));
        r = r_new;
        rsold = rsnew;
    }
    
    x
}

fn main() {
    let A = vec![
        vec![4.0, 1.0],
        vec![1.0, 3.0],
    ];
    let b = vec![1.0, 2.0];

    let tol = 1e-8;

    let x = conjugate_gradient(&A, &b, tol);
    println!("Solution x: {:?}", x);

    // Validate the solution by computing A*x and checking against b
    let Ax = mat_vec_mul(&A, &x);
    println!("A*x should be close to b: {:?}", Ax);
}
