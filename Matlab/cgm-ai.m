% Function to perform matrix-vector multiplication: y = A*x
function y = matVecMult(A, x)
    n = length(x);
    y = zeros(n, 1);
    
    for i = 1:n
        for j = 1:n
            y(i) = y(i) + A(i, j) * x(j);
        end
    end
end

% Function to compute dot product of two vectors
function dot = dotProduct(x, y)
    n = length(x);
    dot = 0;
    
    for i = 1:n
        dot = dot + x(i) * y(i);
    end
end

% Conjugate Gradient Method
function x = conjugateGradient(A, b, tol)
    n = length(b);
    x = zeros(n, 1);
    r = b; % Initial residual: r = b - A*x
    p = r; % Initial search direction
    Ap = zeros(n, 1); % Placeholder for A*p

    alpha = 0;
    beta = 0;
    rsold = 0;
    rsnew = 0;

    % Compute initial residual norm
    rsold = dotProduct(r, r);

    while sqrt(rsold) > tol
        % Matrix-vector multiplication: Ap = A*p
        Ap = matVecMult(A, p);

        % Compute alpha
        alpha = rsold / dotProduct(p, Ap);

        % Update solution: x = x + alpha*p
        x = x + alpha * p;

        % Update residual: r = r - alpha*Ap
        r = r - alpha * Ap;

        % Compute new residual norm
        rsnew = dotProduct(r, r);

        % Compute beta
        beta = rsnew / rsold;

        % Update search direction: p = r + beta*p
        p = r + beta * p;

        % Update rsold for next iteration
        rsold = rsnew;
    end
end

% Example matrix A and vector b
A = [4, 1; 1, 3];
b = [1; 2];

% Tolerance for convergence
tol = 1e-6;

% Solve Ax = b
x = conjugateGradient(A, b, tol);

% Print solution
disp('Solution vector x:');
disp(x);

