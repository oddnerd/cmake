cmake_minimum_required(VERSION 3.20)

# Framework
find_package(Catch2 2.13 QUIET)

if(NOT Catch2_FOUND)
    include(FetchContent)
    FetchContent_Declare(
        catch
        GIT_REPOSITORY https://github.com/catchorg/Catch2.git
        GIT_SHALLOW TRUE
        GIT_TAG v2.13.0
    )
    FetchContent_MakeAvailable(catch)
endif()

# Target
add_executable(tests
    src/main.cpp
)

# Dependencies
target_link_libraries(tests
    PRIVATE Catch2::Catch2
)

# CTest
include(Catch)
catch_discover_tests(tests)
