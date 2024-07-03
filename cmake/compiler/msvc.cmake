cmake_minimum_required(VERSION 3.22)

# Compiler flags
add_compile_options(
    /W4 # All standard warnings.
    /w14265 # A class should likely have virtual destructor.
)

# Treat warnings as errors
option(WARNINGS_AS_ERRORS "Treat warnings as errors." ON)

if(WARNINGS_AS_ERRORS)
    add_compile_options(/WX)
endif()

# Build type flags
set(CMAKE_CXX_FLAGS_DEBUG
    "${CMAKE_CXX_FLAGS_DEBUG} /Z7 /Od /DDEBUG"
)

set(CMAKE_CXX_FLAGS_RELEASE
    "${CMAKE_CXX_FLAGS_RELEASE} /O2 /DNDEBUG"
)

set(CMAKE_CXX_FLAGS_RELWITHDEBINFO
    "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} ${CMAKE_CXX_FLAGS_RELEASE} /Z7"
)

set(CMAKE_CXX_FLAGS_MINSIZEREL
    "${CMAKE_CXX_FLAGS_MINSIZEREL} /O1s /DNDEBUG"
)
