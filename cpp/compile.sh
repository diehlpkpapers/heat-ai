#!/bin/bash

g++ -fopenmp heat-ai-omp-v4.cpp -o heat-ai-omp-v4
g++ -fopenmp heat-ai-omp-v4-debugged.cpp -o heat-ai-omp-v4-debugged

g++ int-ai.cpp -o int-ai
g++ int-ai4.cpp -o int-ai4

g++ cgm-ai.cpp -o cgm-ai

