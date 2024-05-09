program CGSolver
    implicit none
    integer, parameter :: dp = kind(1.0d0)
    integer, parameter :: n = 2
    double precision, dimension(n,n) :: A
    double precision, dimension(n) :: b, x
    double precision, dimension(n) :: r, p, Ap
    double precision :: rsold, rsnew, alpha, beta, tol
    integer :: i, max_iter

    ! Initialize matrix A and vector b
    A = reshape([4.0d0, 1.0d0, &
                 1.0d0, 3.0d0 ], shape=[n, n])
    b = [1.0d0, 2.0d0]
    x = [0.0d0, 0.0d0]  ! Initial guess
    tol = 1.0d-10
    max_iter = 1000

    ! Start of Conjugate Gradient method
    r = b - matmul(A, x)
    p = r
    rsold = dot_product(r, r)

    do i = 1, max_iter
        Ap = matmul(A, p)
        alpha = rsold / dot_product(p, Ap)
        x = x + alpha * p
        r = r - alpha * Ap
        rsnew = dot_product(r, r)

        if (sqrt(rsnew) < tol) then
            print *, "Convergence achieved after ", i, " iterations."
            exit
        endif

        beta = rsnew / rsold
        p = r + beta * p
        rsold = rsnew
    end do

    ! Output the solution
    print *, "Solution x:"
    print *, x

    ! Validate the solution
    print *, "A*x should be close to b:"
    print *, matmul(A, x)
end program CGSolver
