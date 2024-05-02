#!/bin/bash

gfortran heat-ai-debugged.f90 -fopenmp
mpif90 heat-ai-v4-debugged.f90  -fcoarray=single
