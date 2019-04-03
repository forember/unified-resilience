#!/usr/bin/env python2
import rospy
from geometry_msgs.msg import Twist
import sys
import time

def latch(pub, twist, duration):
    remain = duration
    while remain > 0:
        start = rospy.get_time()
        pub.publish(twist)
        section = min(remain, 0.1)
        rospy.sleep(section - (rospy.get_time() - start))
        remain -= rospy.get_time() - start

def main():
    if len(sys.argv) != 4:
        sys.stderr.write("usage: {} <m/s> <rad/s> <sec>\n".format(sys.argv[0]))
        raise SystemExit(2)
    rospy.init_node("move", anonymous=True)
    pub = rospy.Publisher("cmd_vel", Twist, queue_size=1000)
    twist = Twist()
    twist.linear.x = float(sys.argv[1])
    twist.angular.z = float(sys.argv[2])
    duration = float(sys.argv[3])
    latch(pub, Twist(), 3)
    latch(pub, twist, duration)
    latch(pub, Twist(), 3)

if __name__ == "__main__":
    main()
