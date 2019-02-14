#!/bin/bash
export ROS_HOSTNAME="$(curl https://ttech.click/tx2-ip.txt)"
export ROS_MASTER_HOSTNAME="$1"
export ROS_MASTER_URI="http://$ROS_MASTER_HOSTNAME:11311"
export TURTLEBOT3_MODEL=waffle_pi
source "$(dirname "$0")/source.bash"
rosrun resilient_debug_gui gui.py
