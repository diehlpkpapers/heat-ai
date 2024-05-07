import numpy as np
from scipy.integrate import quad

# Define the function
def sin_function(x):
    return np.sin(x)

# Define the integration limits
lower_limit = -np.pi
upper_limit = 2/3 * np.pi

# Compute the definite integral
area, _ = quad(sin_function, lower_limit, upper_limit)

print("Area between -π and 2/3π for sin(x) =", area)
