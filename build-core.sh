cd core
mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$(pwd)/install" -DTRITON_CORE_HEADERS_ONLY=OFF -DTRITON_ENABLE_GPU=ON -DTRITON_ENABLE_S3=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5 ..
cmake --build . --target install -j$(nproc)