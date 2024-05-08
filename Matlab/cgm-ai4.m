function x = conjugateGradient(A, b, x0)
    % CONJUGATEGRADIENT Solves Ax = b using the Conjugate Gradient method
    % A - Symmetric, positive definite matrix
    % b - Right hand side vector
    % x0 - Initial guess for the solution
    
    % Initialize variables
    x = x0;
    r = b - A * x;
    p = r;
    rsOld = r' * r;

    % Main iteration loop
    for i = 1:length(b)
        Ap = A * p;
        alpha = rsOld / (p' * Ap);
        x = x + alpha * p;
        r = r - alpha * Ap;
        rsNew = r' * r;

        % Check for convergence
        if sqrt(rsNew) < 1e-10
            break;
        end

        p = r + (rsNew / rsOld) * p;
        rsOld = rsNew;
    end
end

% Example usage
A = [4, 1, 0; 1, 3, -1; 0, -1, 2];
b = [1; 2; 3];
x0 = zeros(size(b));

% Call the Conjugate Gradient solver
x = conjugateGradient(A, b, x0);

% Display the result
disp('Solution x:');
disp(x);

% Validate the solution by computing A*x and checking against b
Ax = A * x;
disp('A*x should be close to b:');
disp(Ax);
