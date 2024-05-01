% Parameters
L = 10;               % Length of the rod
T = 2;                % Total time
Nx = 100;             % Number of spatial points
Nt = 500;             % Number of time points
alpha = 0.01;         % Thermal diffusivity of the rod

dx = L / (Nx - 1);    % Spatial step size
dt = T / Nt;          % Time step size
x = linspace(0, L, Nx); % Spatial grid

% Initial condition: temperature distribution
u = sin(pi * x / L);

% Boundary conditions: u(0,t) = u(L,t) = 0

% Coefficient in the scheme
r = alpha * dt / dx^2;

% Preallocate the new temperature array
u_new = zeros(size(u));

% Start the parallel pool
pool = parpool; % You can specify the number of workers

for t = 1:Nt
    % Parallel loop
    parfor i = 2:Nx-1
        u_new(i) = u(i) + r * (u(i+1) - 2*u(i) + u(i-1));
    end

    % Update the solution
    u = u_new;
    
    % Enforce boundary conditions
    u(1) = 0;
    u(Nx) = 0;
end

% Close the parallel pool
delete(pool);

plot(x, u);
title('Temperature distribution along the rod');
xlabel('Position');
ylabel('Temperature');
