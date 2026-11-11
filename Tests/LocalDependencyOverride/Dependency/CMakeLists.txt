cmake_minimum_required(VERSION 3.29.3 FATAL_ERROR)

project(LocalTestDependency LANGUAGES CXX)

add_library(LocalTestDependency INTERFACE)
target_compile_definitions(LocalTestDependency INTERFACE LOCAL_TEST_DEPENDENCY_AVAILABLE=1)
