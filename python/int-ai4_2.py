###Python Code Using Scipy for Accurate Integration

from scipy.integrate import quad
import numpy as np

def abs_sin(x):
    return np.abs(np.sin(x))

a = -np.pi
b = 2 * np.pi / 3

# Calculate the area using scipy's quad function for accurate integration
area, error = quad(abs_sin, a, b)
print(f"The total area between sin(x) and the x-axis from -pi to 2/3*pi is: {area:.4f}")
print(f"Estimated error in the computation: {error:.4e}")
