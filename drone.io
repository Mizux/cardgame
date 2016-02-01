#!/bin/bash
# Script to test on drone.io farm
# Suppose to have Ubuntu Precise (12.04) slave

echo "Build Server Setup..."
# https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test?field.series_filter=precise
sudo apt-add-repository ppa:ubuntu-toolchain-r/test # gcc-5 (5.2.1)
# https://launchpad.net/~george-edison55/+archive/ubuntu/precise-backports
sudo apt-add-repository ppa:george-edison55/precise-backports # doxygen (1.8.3), cmake (3.2.3)
# https://launchpad.net/~beineri/+archive/ubuntu/opt-qt551
sudo apt-add-repository ppa:beineri/opt-qt551 # qt55base (5.5.1)
sudo apt-get update
sudo apt-get install qt55base qt55declarative
export PATH="/opt/qt55/bin:$PATH"
# doxygen pull latex
sudo apt-get --no-install-recommends install gcc-5 g++-5 cmake doxygen valgrind
echo 2 | sudo update-alternatives --config gcc
export CXX="g++-5" CC="gcc-5";

echo "Build Server Info..."
echo "$PATH"
cmake --version
qmake --version
gcc --version

echo "Configure..."
mkdir build && cd build
cmake ..

echo "Compile..."
make VERBOSE=1
