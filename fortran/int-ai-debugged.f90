program sin_area
    implicit none
    real :: lower_limit, upper_limit, area
    real :: pi
    external :: sin_function

    ! Define pi
    pi = acos(-1.0)

    ! Define integration limits
    lower_limit = -pi
    upper_limit = 2.0/3.0 * pi

    ! Compute the area using trapezoidal rule
    area = integrate(sin_funct, lower_limit, upper_limit)

    ! Output the result
    print *, 'Area between -π and 2/3π for sin(x) =', area

contains

    ! Function to integrate sin(x) using trapezoidal rule
    real function integrate(func, a, b)
        real, external :: func
        real :: a, b
        integer :: i, n
        real :: h, sum, x

        n = 100000 ! Number of intervals, increase for higher accuracy
        h = (b - a) / real(n)
        sum = 0.5 * (func(a) + func(b))
        do i = 1, n-1
            x = a + real(i) * h
            sum = sum + func(x)
        end do
        integrate = h * sum
    end function integrate

    ! Function sin(x)
    real function sin_funct(x)
        real :: x
        sin_funct = sin(x)
    end function sin_funct

end program sin_area

