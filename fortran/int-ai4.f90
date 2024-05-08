program SinArea
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    double precision, parameter :: pi = 3.14159265358979323846d0
    double precision :: a, b, integral, dx
    integer :: i, n

    ! Integration limits and number of intervals
    a = -pi
    b = 2.0d0 / 3.0d0 * pi
    n = 1000  ! More intervals for better accuracy
    dx = (b - a) / n

    ! Initialize integral
    integral = 0.0d0

    ! Trapezoidal rule to compute the integral of |sin(x)|
    do i = 0, n-1
        integral = integral + (abs(sin(a + i * dx)) + abs(sin(a + (i+1) * dx))) * dx / 2.0d0
    end do

    ! Output the result
    print *, "The total area between sin(x) and the x-axis from -pi to 2/3*pi is:", integral
end program SinArea
