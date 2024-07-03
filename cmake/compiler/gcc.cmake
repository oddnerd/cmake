cmake_minimum_required(VERSION 3.22)

# Sanitizers
option(ENABLE_COVERAGE "Enable coverage reporting" OFF)

if(ENABLE_COVERAGE)
    add_compile_options(--coverage -O0 -g)
    add_link_options(--coverage)
endif()

option(ENABLE_THREAD_SANITIZER "Enable the thread sanitizer" OFF)

if(ENABLE_THREAD_SANITIZER)
    add_compile_options(-fsanitize=thread -g)
    add_link_options(-fsanitize=thread)
endif()

option(ENABLE_ADDRESS_SANITIZER "Enable the address sanitizer" OFF)

if(ENABLE_ADDRESS_SANITIZER)
    add_compile_options(-fsanitize=address -g)
    add_link_options(-fsanitize=address)
endif()

option(ENABLE_MEMORY_SANITIZER "Enable the memory sanitizer" OFF)

if(ENABLE_MEMORY_SANITIZER)
    add_compile_options(-fsanitize=memory -fsanitize-memory-track-origins -g)
    add_link_options(-fsanitize=memory -fsanitize-memory-track-origins)
endif()

option(ENABLE_UNDEFINED_BEHAVIOUR_SANITIZER "Enable the undefined behavior sanitizer" OFF)

if(ENABLE_UNDEFINED_BEHAVIOUR_SANITIZER)
    add_compile_options(-fsanitize=undefined -g)
    add_link_options(-fsanitize=undefined)
endif()

# Compiler flags (https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html)
add_compile_options(
    -Wall # All standard warnings.
    -Wextra # Extra warnings which may give false positives.
    -Wpedantic # Disallow non-standard C++.
    -Wnon-virtual-dtor # A class should likely have virtual destructor.
    -Wconversion # Loss of data through type conversion.
    -Wsign-conversion # Change of sign through type conversion.
    -Wold-style-cast # Use of a C-style cast.
    -Wcast-qual # Case drops qualifiers.
    -Wcast-align # Casting increases required alignment.
    -Wunused # Something was unsued yet left in code.
    -Woverloaded-virtual # Overloaded (instead of overridden) virtual.
    -Wmissing-noreturn # Should be made noreturn.
    -Wunused-template # Template is provided, but not used.
    -Wnull-dereference # Null pointer is dereferenced.
    -Wdouble-promotion # Float implciitly becomes double.
    -Wformat=2 # Dangerous format string.
    -Wmisleading-indentation # Indentation implies nonecistant block.
    -Wduplicated-cond # If chain has duplicat condition.
    -Wduplicated-branches # If chain has duplicate code.
    -Wlogical-op # Suspect logical operator.
    -Wuseless-cast # Unecessary type cast.
)

# Treat warnings as errors
option(WARNINGS_AS_ERRORS "Treat warnings as errors." ON)

if(WARNINGS_AS_ERRORS)
    add_compile_options(-Werror)
endif()

# Build type
set(CMAKE_CXX_FLAGS_DEBUG
    "${CMAKE_CXX_FLAGS_DEBUG} -g -Og -DDEBUG"
)

set(CMAKE_CXX_FLAGS_RELEASE
    "${CMAKE_CXX_FLAGS_RELEASE} -O3 -DNDEBUG"
)

set(CMAKE_CXX_FLAGS_RELWITHDEBINFO
    "${CMAKE_CXX_FLAGS_RELWITHDEBINFO} ${CMAKE_CXX_FLAGS_RELEASE} -g"
)

set(CMAKE_CXX_FLAGS_MINSIZEREL
    "${CMAKE_CXX_FLAGS_MINSIZEREL} -Os -DNDEBUG"
)
