% Define the function
sin_function = @(x) sin(x);

% Define the integration limits
lower_limit = -pi;
upper_limit = 2/3 * pi;

% Compute the definite integral using quad function
area = integral(sin_function, lower_limit, upper_limit);

fprintf('Area between -π and 2/3π for sin(x) = %.6f\n', area);

