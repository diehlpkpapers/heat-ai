% Parameters
L = 1;          % Length of the rod
T = 0.5;        % Total time
Nx = 100;       % Number of spatial grid points
Nt = 1000;      % Number of time steps
alpha = 0.01;   % Thermal diffusivity

dx = L / (Nx - 1);
dt = T / Nt;
x = linspace(0, L, Nx)';
u = zeros(Nx, Nt); % Temperature distribution

% Initial condition
u(:,1) = sin(pi * x);

% Boundary conditions
u(1,:) = 0;     % Left boundary
u(Nx,:) = 0;    % Right boundary

% Main loop
for n = 1:Nt-1
    % Compute the temperature distribution at the next time step
    for i = 2:Nx-1
        u(i,n+1) = u(i,n) + alpha * dt / dx^2 * (u(i+1,n) - 2 * u(i,n) + u(i-1,n));
    end
end

% Plotting
figure;
for n = 1:10:Nt
    plot(x, u(:,n));
    title(['Time step = ', num2str(n)]);
    xlabel('Position');
    ylabel('Temperature');
    ylim([-1, 1]);  % Adjust the y-axis limits if needed
    pause(0.1);     % Pause to show the plot
end
