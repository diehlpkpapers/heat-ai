program heat_equation
    implicit none
    integer, parameter :: nx = 100, nt = 500
    real, parameter :: alpha = 0.01, dx = 1.0 / (nx - 1), dt = 0.01 
    real, parameter :: PI = 3.14159265358979323846264338327950288419716939937510
    real :: u(nx)[*], u_new(nx)
    integer :: i, t, image_id, num_image

    ! Initialize parallel environment
    image_id = this_image()
    num_image = num_images()

    ! Initial condition: e.g., u(x,0) = sin(pi * x)
    if (image_id == 1) then
        do i = 1, nx
            u(i) = sin(PI * real(i - 1) * dx)
        end do
    end if

    call co_broadcast(u, nx) ! Broadcast initial condition from image 1 to all

    ! Time stepping
    do t = 1, nt
        ! Update interior points
        do i = 2, nx - 1
            u_new(i) = u(i) + alpha * dt / (dx * dx) * (u(i - 1) - 2.0 * u(i) + u(i + 1))
        end do

        ! Boundary conditions
        if (image_id == 1) then
            u_new(1) = 0.0
            u_new(nx) = 0.0
        end if

        ! Update solution
        u = u_new
    end do

    ! Output the solution
    if (image_id == 1) then
        do i = 1, nx
            print *, 'u(', i, ') = ', u(i)
        end do
    end if
end program heat_equation
