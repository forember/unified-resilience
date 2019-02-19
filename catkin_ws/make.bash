#!/bin/bash
cd "$(dirname "$0")"
wd="$(pwd)"
source source.bash
cd ../xiaofeng-slam
[ "$1" = '-c' ] && catkin clean --yes
catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug --
. devel/setup.bash
cd "$wd"
[ "$1" = '-c' ] && catkin clean --yes
catkin build --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug -- "$@"
