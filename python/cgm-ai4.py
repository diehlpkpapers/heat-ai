import numpy as np

def conjugate_gradient(A, b, tol=1e-10, max_iter=1000):
    n = len(b)
    x = np.zeros(n)  # Initial guess
    r = b - np.dot(A, x)
    p = r.copy()
    rsold = np.dot(r, r)

    for i in range(max_iter):
        Ap = np.dot(A, p)
        alpha = rsold / np.dot(p, Ap)
        x += alpha * p
        r -= alpha * Ap
        rsnew = np.dot(r, r)

        if np.sqrt(rsnew) < tol:
            print(f"Convergence achieved after {i+1} iterations.")
            break

        p = r + (rsnew / rsold) * p
        rsold = rsnew

    return x

# Example to validate the solver
A = np.array([
    [4, 1, 0],
    [1, 3, -1],
    [0, -1, 2]
], dtype=float)

b = np.array([1, 2, 3], dtype=float)

# Solve the system
x = conjugate_gradient(A, b)

# Print the solution
print("Solution x:")
print(x)

# Validate the solution by computing A*x and checking against b
Ax = np.dot(A, x)
print("Computed A*x, should be close to b:")
print(Ax)
