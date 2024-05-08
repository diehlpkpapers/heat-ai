% Define the function to be integrated
f = @(x) abs(sin(x));

% Set the limits of integration
a = -pi;
b = 2*pi/3;

% Perform the integration using the integral function
area = integral(f, a, b);

% Display the result
fprintf('The total area between sin(x) and the x-axis from -pi to 2/3*pi is: %.4f\n', area);
