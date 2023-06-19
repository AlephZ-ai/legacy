#!/usr/bin/env bash
set -euo pipefail
pushd /usr/src/gtest
sudo cmake CMakeLists.txt
sudo make
#copy or symlink libgtest.a and libgtest_main.a to your /usr/lib folder
sudo cp ./*.a /usr/lib
popd
