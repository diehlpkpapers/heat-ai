import numpy as np

# Function to perform matrix-vector multiplication: y = A*x
def matVecMult(A, x):
    return np.dot(A, x)

# Function to compute dot product of two vectors
def dotProduct(x, y):
    return np.dot(x, y)

# Conjugate Gradient Method
def conjugateGradient(A, b, tol=1e-6):
    n = len(b)
    x = np.zeros(n)
    r = b - matVecMult(A, x)  # Initial residual: r = b - A*x
    p = np.copy(r)             # Initial search direction
    Ap = np.zeros(n)           # Placeholder for A*p

    rsold = dotProduct(r, r)   # Compute initial residual norm

    while np.sqrt(rsold) > tol:
        # Matrix-vector multiplication: Ap = A*p
        Ap = matVecMult(A, p)

        # Compute alpha
        alpha = rsold / dotProduct(p, Ap)

        # Update solution: x = x + alpha*p
        x += alpha * p

        # Update residual: r = r - alpha*Ap
        r -= alpha * Ap

        # Compute new residual norm
        rsnew = dotProduct(r, r)

        # Compute beta
        beta = rsnew / rsold

        # Update search direction: p = r + beta*p
        p = r + beta * p

        # Update rsold for next iteration
        rsold = rsnew

    return x

# Example matrix A and vector b
A = np.array([[4, 1], [1, 3]])
b = np.array([1, 2])

# Tolerance for convergence
tol = 1e-6

# Solve Ax = b
x = conjugateGradient(A, b, tol)

# Print solution
print("Solution vector x:")
print(x)

