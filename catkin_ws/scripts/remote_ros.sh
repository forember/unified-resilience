#!/bin/sh
ROS_MASTER_URI="http://$(curl https://ttech.click/tx2-ip.txt):11311" "$@"
