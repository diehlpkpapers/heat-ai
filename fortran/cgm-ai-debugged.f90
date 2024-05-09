program conjugate_gradient
    implicit none
    integer, parameter :: n = 2
    real :: A(n,n), b(n), x(n), r(n), p(n), Ap(n)
    real :: alpha, beta, rsold, rsnew, tol
    integer :: i, iter
    !real :: dot_product

    ! Example matrix A and vector b
    A = reshape([4.0, 1.0, 1.0, 3.0], [n, n])
    b = [1.0, 2.0]

    ! Initial guess for x
    x = 0.0

    ! Initial residual: r = b - A*x
    call matvecmult(n, A, x, Ap)
    r = b - Ap

    ! Initial search direction
    p = r

    ! Convergence tolerance
    tol = 1e-6

    ! Compute initial residual norm
    rsold = dot_product(r, r)

    ! Conjugate gradient iterations
    iter = 0
    do while (sqrt(rsold) > tol)
        iter = iter + 1

        ! Matrix-vector multiplication: Ap = A*p
        call matvecmult(n, A, p, Ap)

        ! Compute alpha
        alpha = rsold / dot_product(p, Ap)

        ! Update solution: x = x + alpha*p
        x = x + alpha * p

        ! Update residual: r = r - alpha*Ap
        r = r - alpha * Ap

        ! Compute new residual norm
        rsnew = dot_product(r, r)

        ! Compute beta
        beta = rsnew / rsold

        ! Update search direction: p = r + beta*p
        p = r + beta * p

        ! Update rsold for next iteration
        rsold = rsnew
    end do

    ! Output solution vector x
    print *, "Solution vector x:"
    do i = 1, n
        print *, "x(", i, ") = ", x(i)
    end do

contains

    ! Function to perform matrix-vector multiplication: y = A*x
    subroutine matvecmult(n, A, x, y)
        implicit none
        integer, intent(in) :: n
        real, intent(in) :: A(n,n), x(n)
        real, intent(out) :: y(n)
        integer :: i, j

        do i = 1, n
            y(i) = 0.0
            do j = 1, n
                y(i) = y(i) + A(i,j) * x(j)
            end do
        end do
    end subroutine matvecmult

    ! Function to compute dot product of two vectors
    real function dot_product(x, y)
        implicit none
        real, intent(in) :: x(n), y(n)
        integer :: i
        dot_product = 0.0
        do i = 1, n
            dot_product = dot_product + x(i) * y(i)
        end do
    end function dot_product

end program conjugate_gradient

