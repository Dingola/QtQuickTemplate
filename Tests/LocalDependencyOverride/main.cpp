/**
 * @file main.cpp
 * @brief Verifies that the local dependency target contributes its usage requirements.
 */

#ifndef LOCAL_TEST_DEPENDENCY_AVAILABLE
#error "The local dependency target was not linked."
#endif

/**
 * @brief Provides the minimal executable entry point for the CMake smoke test.
 * @return Zero when the fixture linked successfully.
 */
auto main() -> int
{
    const int result = 0;
    return result;
}
