#!/bin/sh
cd "$(dirname "$0")"
catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug -- "$@"
