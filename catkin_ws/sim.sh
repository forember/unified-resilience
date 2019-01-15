#!/bin/sh
cd "$(dirname "$0")"
if [ "$1" = '-c' ]
then
  catkin clean
  ./make.sh
  . devel/setup.sh
  cd ../xiaofeng-slam
  catkin clean
  catkin build
else
  cd ../xiaofeng-slam
fi
pwd
. devel/setup.sh
roslaunch slam slam-sim.launch
