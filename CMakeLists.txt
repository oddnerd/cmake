cmake_minimum_required(VERSION 3.22)

# Top level project (this repository)
project(cmake
    VERSION 0.1.0
    DESCRIPTION "Template CMake project for C++"
    HOMEPAGE_URL "github.com/oddnerd/cmake"
    LANGUAGES CXX
)

# CMake modules
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_SOURCE_DIR}/cmake
)

# C++ standard defaults
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED OFF)
set(CMAKE_CXX_EXTENSIONS OFF)

# Use ccache to speed up builds.
option(USE_CCACHE "Use ccache to speed up incremental builds" ON)
mark_as_advanced(USE_CCACHE)
find_program(CCACHE ccache)

if(CCACHE AND USE_CCACHE)
    message(NOTICE "Using ccache")
    set(CMAKE_CXX_COMPILER_LAUNCHER ${CCACHE})
endif()

# Documentation
option(BUILD_DOCUMENTATION "Build documentation." OFF)

if(BUILD_DOCUMENTATION)
    add_subdirectory(doc)
    message(NOTICE "Building documentation.")
endif()

# Testing
if(ENABLE_TESTING)
    enable_testing()
    include(CTest)
    add_subdirectory(test)
    message(NOTICE "Building Tests")
endif()

# Compiler flags
if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    include(compiler/clang)
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    include(compiler/gcc)
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    include(compiler/msvc)
else()
    message(WARNING "Unknown compiler")
endif()

# Inerprocedural optimization (link time optimization)
option(ENABLE_IPO "Iterprocedural Optimization; Link Time Optimization (LTO)" OFF)

if(ENABLE_IPO)
    include(CheckIPOSupported)
    check_ipo_supported(RESULT result OUTPUT output)

    if(result)
        set(CMAKE_INTERPROCEDURAL_OPTIMIZATION TRUE)
    else()
        message(SEND_ERROR "IPO is not supported: ${output}")
    endif()
endif()

# Static analysis
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_LINK_WHAT_YOU_USE TRUE)

# CPPCheck
option(ENABLE_CPPCHECK "Use cppcheck" OFF)

if(ENABLE_CPPCHECK)
    find_program(CPPCHECK cppcheck)

    if(CPPCHECK)
        set(CMAKE_CXX_CPPCHECK ${CPPCHECK}
            --suppress=missingInclude
            --enable=all
            --inconclusive
        )
    else()
        message(SEND_ERROR "Could not find cppcheck")
    endif()
endif()

# Clang-Tidy
option(ENABLE_CLANG_TIDY "Use clang-tidy" OFF)

if(ENABLE_CLANG_TIDY)
    find_program(CLANGTIDY clang-tidy)

    if(CLANGTIDY)
        set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY})
    else()
        message(SEND_ERROR "Could not find clang-tidy")
    endif()
endif()
