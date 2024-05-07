# Function to perform matrix-vector multiplication: y = A*x
function matVecMult(A, x)
    n = length(x)
    y = zeros(n)
    
    for i in 1:n
        for j in 1:n
            y[i] += A[i, j] * x[j]
        end
    end
    
    return y
end

# Function to compute dot product of two vectors
function dotProduct(x, y)
    n = length(x)
    dot = 0.0
    
    for i in 1:n
        dot += x[i] * y[i]
    end
    
    return dot
end

# Conjugate Gradient Method
function conjugateGradient(A, b, tol=1e-6)
    n = length(b)
    x = zeros(n)
    r = copy(b) # Initial residual: r = b - A*x
    p = copy(r) # Initial search direction
    Ap = zeros(n) # Placeholder for A*p

    alpha, beta, rsold, rsnew = 0.0, 0.0, 0.0, 0.0

    # Compute initial residual norm
    rsold = dotProduct(r, r)

    while sqrt(rsold) > tol
        # Matrix-vector multiplication: Ap = A*p
        Ap = matVecMult(A, p)

        # Compute alpha
        alpha = rsold / dotProduct(p, Ap)

        # Update solution: x = x + alpha*p
        x .+= alpha .* p

        # Update residual: r = r - alpha*Ap
        r .-= alpha .* Ap

        # Compute new residual norm
        rsnew = dotProduct(r, r)

        # Compute beta
        beta = rsnew / rsold

        # Update search direction: p = r + beta*p
        p = r .+ beta .* p

        # Update rsold for next iteration
        rsold = rsnew
    end

    return x
end

# Example matrix A and vector b
A = [4.0 1.0; 1.0 3.0]
b = [1.0, 2.0]

# Solve Ax = b
x = conjugateGradient(A, b)

# Print solution
println("Solution vector x:")
for i in 1:length(x)
    println("x[$i] = $(round(x[i], digits=6))")
end

