#!/bin/bash
set -x
cd "$(dirname "$0")/.."
cmake_args="--cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Debug"
command -v gcc-8 && command -v g++-8 \
    && cmake_args="$cmake_args -DCMAKE_C_COMPILER=gcc-8 -DCMAKE_CXX_COMPILER=g++-8"
cmake_args="$cmake_args --"
[ "$1" = '-c' ] && catkin clean --yes
blacklist="mckinnc_ekf resilient_debug_gui"
command -v nvcc || blacklist="$blacklist zed_ar_track_alvar_example \
  zed_depth_sub_tutorial zed_display_rviz zed_nodelet_example zed_ros \
  zed_rtabmap_example zed_tracking_sub_tutorial zed_video_sub_tutorial zed_wrapper"
catkin config --blacklist $blacklist
catkin build $cmake_args "$@"
