conjugateGradient <- function(A, b, tol = 1e-10, max.iter = length(b)) {
  n <- length(b)
  x <- rep(0, n) # Initial guess (x0)
  r <- b - A %*% x
  p <- r
  rsold <- crossprod(r, r)
  
  for (i in 1:max.iter) {
    Ap <- A %*% p
    alpha <- as.numeric(rsold / crossprod(p, Ap))
    x <- x + alpha * p
    r <- r - alpha * Ap
    rsnew <- crossprod(r, r)
    
    if (sqrt(rsnew) < tol) {
      cat("Convergence achieved.\n")
      break
    }
    
    p <- r + (rsnew / rsold) * p
    rsold <- rsnew
  }
  
  return(x)
}

# Example usage
A <- matrix(c(4, 1, 0,
              1, 3, -1,
              0, -1, 2), nrow = 3, byrow = TRUE)
b <- c(1, 2, 3)

# Call the Conjugate Gradient solver
x <- conjugateGradient(A, b)

# Display the result
cat("Solution x:\n")
print(x)

# Validate the solution by computing A*x and checking against b
Ax <- A %*% x
cat("A*x should be close to b:\n")
print(Ax)
