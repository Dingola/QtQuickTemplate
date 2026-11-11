#[[
@brief Provides the installed-package fallback used by the local dependency override smoke test.
]]

if(NOT TARGET LocalTestDependency)
    add_library(LocalTestDependency INTERFACE IMPORTED)
    set_target_properties(
        LocalTestDependency
        PROPERTIES INTERFACE_COMPILE_DEFINITIONS LOCAL_TEST_DEPENDENCY_AVAILABLE
    )
endif()

set(LocalTestDependency_FOUND TRUE)
