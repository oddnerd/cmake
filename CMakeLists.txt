cmake_minimum_required(VERSION 3.22)

# Top level project (this repository)
project(cmake
    VERSION 0.1.0
    DESCRIPTION "Template CMake project for C++"
    HOMEPAGE_URL "github.com/oddnerd/cmake"
    LANGUAGES CXX
)

# C++ standard defaults
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED OFF)
set(CMAKE_CXX_EXTENSIONS OFF)
