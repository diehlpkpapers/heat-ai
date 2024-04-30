program heat_equation_solver
    implicit none
    
    ! Parameters
    real(kind=8), parameter :: L = 1.0        ! Length of the rod
    real(kind=8), parameter :: T = 0.5        ! Total time
    integer, parameter :: Nx = 100            ! Number of grid points in space
    integer, parameter :: Nt = 1000           ! Number of time steps
    real(kind=8), parameter :: ALPHA = 0.01   ! Thermal diffusivity
    real(kind=8) :: DX, DT                    ! Spatial and time step size
    integer :: i, t                           ! Loop variables
    
    ! Declare temperature arrays
    real(kind=8), dimension(0:Nx) :: u, new_u
    
    ! Initialize parameters
    DX = L / real(Nx)
    DT = T / real(Nt)
    
    ! Initialize temperature distribution
    u = 0.0
    do i = int(0.4 / DX), int(0.6 / DX)
        u(i) = 1.0     ! Initial temperature profile (step function)
    end do
    
    ! Solve heat equation using finite differences in parallel
    do t = 1, Nt
        !$omp parallel do private(i) shared(u, new_u)
        do i = 1, Nx - 1
            new_u(i) = u(i) + ALPHA * DT / (DX * DX) * (u(i-1) - 2 * u(i) + u(i+1))
        end do
        !$omp end parallel do
        
        ! Update temperature array
        u(1:Nx-1) = new_u(1:Nx-1)
    end do
    
    ! Print final temperature distribution
    print *, 'Final Temperature Distribution:'
    do i = 0, Nx
        print *, 'Node ', i, ': Temperature = ', u(i)
    end do
end program heat_equation_solver

