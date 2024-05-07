using QuadGK

# Define the function
function sin_function(x)
    return sin(x)
end

# Define the integration limits
lower_limit = -pi
upper_limit = 2/3 * pi

# Compute the definite integral
area, _ = quadgk(sin_function, lower_limit, upper_limit)

println("Area between -π and 2/3π for sin(x) = ", area)
