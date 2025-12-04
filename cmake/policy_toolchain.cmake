# Minimal toolchain shim to propagate legacy policy compatibility to
# every CMake project configured during the build. This avoids nested
# ExternalProject builds (for example aws-sdk-cpp) failing with
# "Compatibility with CMake < 3.5" errors when CMake 3.31+ is used.

# Force the minimum policy version that downstream projects may rely on.
# Use CACHE so the setting propagates when this toolchain is forwarded
# via -DCMAKE_TOOLCHAIN_FILE.
set(CMAKE_POLICY_VERSION_MINIMUM 3.5 CACHE STRING "Downstream policy floor" FORCE)

# GCC treats some speculative vector indexing paths in core/filesystem/api.cc
# as maybe-uninitialized, and Triton's build uses -Werror globally. Downgrade
# just that diagnostic to a warning whenever this toolchain is active so every
# ExternalProject inherits the exception.
add_compile_options($<$<AND:$<COMPILE_LANGUAGE:CXX>,$<C_COMPILER_ID:GNU>>:-Wno-error=maybe-uninitialized>)
