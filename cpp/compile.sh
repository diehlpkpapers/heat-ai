#!/bin/bash

g++ -fopenmp heat-ai-omp.cpp -o heat-ai-omp
g++ -fopenmp heat-ai-omp-v4.cpp -o heat-ai-omp-v4
g++ -fopenmp heat-ai-omp-v4-debugged.cpp -o heat-ai-omp-v4-debugged
