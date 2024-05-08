###Python Code Using Numpy for Trapezoidal Integration
import numpy as np

def trapezoidal_rule(f, a, b, n):
    x = np.linspace(a, b, n + 1)
    y = f(x)
    h = (b - a) / n
    return h * (np.sum(y) - 0.5 * (y[0] + y[-1]))

# Define the function and limits
f = np.abs(np.sin)  # Taking the absolute value of sin(x)
a = -np.pi
b = 2 * np.pi / 3
n = 10000  # Number of intervals

# Calculate the area using the trapezoidal rule
area = trapezoidal_rule(f, a, b, n)
print(f"The total area between sin(x) and the x-axis from -pi to 2/3*pi is: {area:.4f}")
