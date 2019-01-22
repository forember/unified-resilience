#!/bin/bash
cd "$(dirname "$0")"
. /opt/ros/melodic/setup.bash
if [ "$1" = '-c' ]
then
  catkin clean --yes
  ./make.bash
  . devel/setup.bash
  cd ../xiaofeng-slam
  catkin clean --yes
  catkin build
else
  cd ../xiaofeng-slam
fi
pwd
. devel/setup.bash
rosls slam/launch
roslaunch slam slam-sim.launch
