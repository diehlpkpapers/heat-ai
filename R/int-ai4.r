# Define the function to integrate
f <- function(x) abs(sin(x))

# Set the limits of integration
lower_limit <- -pi
upper_limit <- 2/3 * pi

# Perform the integration
area_result <- integrate(f, lower_limit, upper_limit)

# Print the result
print(paste("The total area between sin(x) and the x-axis from -pi to 2/3*pi is:", area_result$value))
