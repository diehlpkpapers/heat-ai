### Compilation

```bash
heat-ai-omp-v4.cpp: In function ‘int main()’:
heat-ai-omp-v4.cpp:29:71: error: ‘Nx’ is predetermined ‘shared’ for ‘shared’
         #pragma omp parallel for default(none) shared(u, u_new, Nx, r)
                                                                       ^
heat-ai-omp-v4.cpp:29:71: error: ‘r’ is predetermined ‘shared’ for ‘shared’
```
