#!/bin/bash
#  Copyright (c) 2024 AUTHORS
#
#  SPDX-License-Identifier: BSL-1.0
#  Distributed under the Boost Software License, Version 1.0. (See accompanying
#  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

gfortran heat-ai-debugged.f90 -fopenmp
mpif90 heat-ai-v4-debugged.f90  -fcoarray=single
