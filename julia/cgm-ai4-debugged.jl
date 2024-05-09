# Function to compute dot product of two vectors
function dot(x, y)
    n = length(x)
    dot = 0.0
    
    for i in 1:n
        dot += x[i] * y[i]
    end
    
    return dot
end


function conjugateGradient(A, b; tol = 1e-10, maxIter = 1000)
    n = length(b)
    x = zeros(n)
    r = b - A * x
    p = copy(r)
    rsold = dot(r, r)
    for i = 1:maxIter
        Ap = A * p
        alpha = rsold / dot(p, Ap)
        x += alpha * p
        r -= alpha * Ap
        rsnew = dot(r, r)
        if sqrt(rsnew) < tol
            println("Convergence achieved after $i iterations.")
            break
        end
        p = r + (rsnew / rsold) * p
        rsold = rsnew
    end
    return x
end

# Example usage
A = [4.0 1.0; 1.0 3.0]
b = [1.0, 2.0]

# Call the Conjugate Gradient solver
x = conjugateGradient(A, b)

# Display the result
println("Solution x:")
println(x)

# Validate the solution by computing A*x and checking against b
Ax = A * x
println("A*x should be close to b:")
println(Ax)
