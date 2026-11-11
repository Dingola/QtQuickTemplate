cmake_minimum_required(VERSION 3.29.3 FATAL_ERROR)

project(LocalDependencyOverrideFixture LANGUAGES CXX)

set(MAIN_PROJECT_NAME ${PROJECT_NAME})
set(${MAIN_PROJECT_NAME}_INCLUDE_THIRD_LIBS_INTO_SOLUTION OFF)
set(THIRD_PARTY_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/Fallback")

add_executable(${PROJECT_NAME} main.cpp)

include(${CMAKE_CURRENT_LIST_DIR}/../../template/CMake/IncludeThirdParty.cmake)

include_third_party_library(
    "LocalTestDependency"
    "https://invalid.example/LocalTestDependency.git"
    "main"
    "PRIVATE"
)
