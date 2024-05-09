### Instruction

```bash
gfortran -fopenmp heat_equation_parallel.f90 -o heat_equation_parallel
```
### Compilation

```bash
gfortran heat-ai.f90 -fopenmp
heat-ai.f90:11:19:

     integer :: i, t                           ! Loop variables
                   1
Error: Symbol ‘t’ at (1) already has basic type of REAL
heat-ai.f90:22:8:

     do i = int(0.4 / DX), int(0.6 / DX)
        1
Error: Symbol ‘i’ at (1) has no IMPLICIT type
heat-ai.f90:29:24:

         do i = 1, Nx - 1
                        1
Error: !$OMP PARALLEL DO iteration variable must be of type integer at (1)
heat-ai.f90:27:7:

     do t = 1, Nt
       1
Warning: Deleted feature: Loop variable at (1) must be integer
heat-ai.f90:27:7:

     do t = 1, Nt
       1
Error: Named constant ‘t’ in variable definition context (iterator variable) at (1)
```

```bash
 gfortran heat-ai-v4.f90 -fopenmp -fcoarray=lib
heat-ai-v4.f90:10:4:

     num_images = num_images()
    1
Error: Unclassifiable statement at (1)
heat-ai-v4.f90:15:25:

             u(i) = sin(pi * real(i - 1) * dx)
                         1
Error: Symbol ‘pi’ at (1) has no IMPLICIT type; did you mean ‘i’?
heat-ai-v4.f90:19:29:

     call co_broadcast(u, nx, 1) ! Broadcast initial condition from image 1 to all
                             1
Error: ‘stat’ argument of ‘co_broadcast’ intrinsic at (1) must be a variable
```

```bash
gfortran int-ai.f90
int-ai.f90:40:30:

     real function sin_function(x)
                              1
Error: EXTERNAL attribute conflicts with FUNCTION attribute in ‘sin_function’ at (1)
```

```bash
gfortran cgm-ai.f90
cgm-ai.f90:84:29:

     real function dot_product(x, y)
                             1
Error: Procedure ‘dot_product’ at (1) has an explicit interface from a previous declaration
cgm-ai.f90:84:35:

     real function dot_product(x, y)
                                   1
Error: Symbol ‘dot_product’ at (1) already has basic type of REAL
cgm-ai.f90:85:21:

         implicit none
                     1
Error: Unexpected IMPLICIT NONE statement in CONTAINS section at (1)
cgm-ai.f90:86:38:

         real, intent(in) :: x(n), y(n)
                                      1
Error: Unexpected data declaration statement in CONTAINS section at (1)
cgm-ai.f90:87:20:

         integer :: i
                    1
Error: Unexpected data declaration statement in CONTAINS section at (1)
cgm-ai.f90:88:19:

         dot_product = 0.0
                   1
Error: Symbol ‘dot_product’ at (1) has already been host associated
cgm-ai.f90:89:19:

         do i = 1, n
                   1
Error: Unexpected DO statement in CONTAINS section at (1)
cgm-ai.f90:90:23:

             dot_product = dot_product + x(i) * y(i)
                       1
Error: Symbol ‘dot_product’ at (1) has already been host associated
cgm-ai.f90:91:11:

         end do
           1
Error: Expecting END PROGRAM statement at (1)
cgm-ai.f90:92:7:

     end function dot_product
       1
Error: Expecting END PROGRAM statement at (1)
```
### Correctness

```bash
./int-ai4
 The total area between sin(x) and the x-axis from -pi to 2/3*pi is:   3.4999920037890746
```

