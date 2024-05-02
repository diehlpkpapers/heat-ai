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
