# Common variables.
cmake_minimum_required  (VERSION 2.8)
project                 (munkres-cpp)

set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
set (CMAKE_CXX_FLAGS_DEBUG   "${CMAKE_CXX_FLAGS} -O0 -ggdb3 -DDEBUG")
set (CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O3")



include_directories( ${CMAKE_CURRENT_SOURCE_DIR}/include )
#include_directories( ${PROJECT_SOURCE_DIR}/src )



# Example
add_executable (ensalador src/main.cpp src/database.cpp src/ensalador.cpp src/rooms.cpp)
target_link_libraries (ensalador munkres yaml-cpp)
install (TARGETS ensalador DESTINATION bin)
