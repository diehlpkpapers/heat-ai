#  Copyright (c) 2024 AUTHORS
#
#  SPDX-License-Identifier: BSL-1.0
#  Distributed under the Boost Software License, Version 1.0. (See accompanying
#  file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

cmake_minimum_required(VERSION 3.20)
set(CMAKE_CXX_STANDARD 20)

project(heat_ai
    DESCRIPTION  "1D heat equation solver in HPX"
    LANGUAGES CXX)

# Add own cmake scripts
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

# Set director for all exectuables
set(EXECUTABLE_OUTPUT_PATH "${PROJECT_BINARY_DIR}/bin")

#HPX
find_package(HPX REQUIRED)

add_hpx_executable(heat_ghosts_v3 SOURCES heat-ai.cpp)
add_hpx_executable(heat_ghosts_v4 SOURCES heat-ai-v4.cpp)
