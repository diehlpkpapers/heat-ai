# Function to perform matrix-vector multiplication: y = A*x
matVecMult <- function(A, x) {
  return(A %*% x)
}

# Function to compute dot product of two vectors
dotProduct <- function(x, y) {
  return(sum(x * y))
}

# Conjugate Gradient Method
conjugateGradient <- function(A, b, tol=1e-6) {
  n <- length(b)
  x <- rep(0, n)
  r <- b - matVecMult(A, x)  # Initial residual: r = b - A*x
  p <- r                     # Initial search direction
  Ap <- rep(0, n)            # Placeholder for A*p

  rsold <- dotProduct(r, r)  # Compute initial residual norm

  while (sqrt(rsold) > tol) {
    # Matrix-vector multiplication: Ap = A*p
    Ap <- matVecMult(A, p)
    
    # Compute alpha
    alpha <- rsold / dotProduct(p, Ap)
    
    # Update solution: x = x + alpha*p
    x <- x + alpha * p
    
    # Update residual: r = r - alpha*Ap
    r <- r - alpha * Ap
    
    # Compute new residual norm
    rsnew <- dotProduct(r, r)
    
    # Compute beta
    beta <- rsnew / rsold
    
    # Update search direction: p = r + beta*p
    p <- r + beta * p
    
    # Update rsold for next iteration
    rsold <- rsnew
  }
  
  return(x)
}

# Example matrix A and vector b
A <- matrix(c(4, 1, 1, 3), nrow=2, byrow=TRUE)
b <- c(1, 2)

# Tolerance for convergence
tol <- 1e-6

# Solve Ax = b
x <- conjugateGradient(A, b, tol)

# Print solution
cat("Solution vector x:\n")
cat(x, "\n")

