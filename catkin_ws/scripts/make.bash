#!/bin/bash
cd "$(dirname "$0")"
wd="$(pwd)"
source source.bash
cd ../../xiaofeng-slam
[ "$1" = '-c' ] && catkin clean --yes
cmake_args="--cmake-args \
  -DCMAKE_C_COMPILER=gcc-8 -DCMAKE_CXX_COMPILER=g++-8
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug --"
catkin build $cmake_args
. devel/setup.bash
cd "$wd"
[ "$1" = '-c' ] && catkin clean --yes
catkin build $cmake_args "$@"
