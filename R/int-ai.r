# Define the function
sin_function <- function(x) {
  return(sin(x))
}

# Define the integration limits
lower_limit <- -pi
upper_limit <- 2/3 * pi

# Compute the definite integral using integrate function
area <- integrate(sin_function, lower_limit, upper_limit)$value

cat("Area between -π and 2/3π for sin(x) =", area, "\n")

