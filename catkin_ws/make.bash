#!/bin/bash
cd "$(dirname "$0")"
wd="$(pwd)"
cd ../xiaofeng-slam
catkin build
. devel/setup.bash
cd "$wd"
catkin clean
catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug -- "$@"
