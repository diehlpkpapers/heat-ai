# Function to implement the trapezoidal rule for integration
function trapezoidal_rule(f, a, b, n)
    dx = (b - a) / n
    area = 0.0
    for i = 1:n
        x_i = a + (i-1) * dx
        x_next = a + i * dx
        area += 0.5 * (f(x_i) + f(x_next)) * dx
    end
    return area
end

# Function for the absolute value of sin(x)
abs_sin(x) = abs(sin(x))

# Define the limits of integration and number of intervals
a = -pi
b = 2/3 * pi
n = 10000  # Using a large number of intervals for better accuracy

# Compute the area using the trapezoidal rule
area = trapezoidal_rule(abs_sin, a, b, n)

# Output the computed area
println("The total area between sin(x) and the x-axis from -pi to 2/3*pi is: ", area)
