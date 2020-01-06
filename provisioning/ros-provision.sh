# Shell flags
set -x
set -e
# Prevent apt-get from asking us questions
export DEBIAN_FRONTEND=noninteractive
# From RSL root project
apt-get install -y libxml2 kmod libatk1.0-0 libgdk-pixbuf2.0-0 libgtk2.0-0 \
  less libpangox-1.0-0 libpangoxft-1.0-0 xterm htop gcc-8 g++-8 mosh nmap curl \
  git silversearcher-ag simplescreenrecorder sudo pandoc mlocate psmisc \
  vim-gtk3 build-essential powerline python3-powerline cmake python-dev \
  python3-dev zsh libgtk-3-0 python-gi python-gi-dev python-gi-cairo python-pil \
  python-pip gir1.2-gtk-3.0 libgtk-3-dev libgtk-3-doc python-future{,-doc} \
  python-opencv python-requests ninja-build libqt5svg5-dev \
  libqt5serialport5-dev libeigen3-dev
apt-get install -y --install-suggests texlive-latex-recommended
# Install ROS
echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/ros-latest.list
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key \
    F42ED6FBAB17C654
apt-get update
apt-get upgrade -y
apt-get install -y ros-melodic-desktop-full
rosdep init
# Set up rosdep
cd /home/vagrant
sudo -H -u vagrant rosdep update
apt-get install -y python-rosinstall python-rosinstall-generator
apt-get install -y python-wstool
# Chown home
chown vagrant:vagrant .
chown vagrant:vagrant *
chown -R vagrant:vagrant .[crv]*
# Install catkin tools
apt-get install -y python-catkin-tools
# Install turtlebot3 prereqs
sudo apt-get install -y ubuntu-drivers-common \
  ros-melodic-{rqt-image-view,image-view} \
  ros-melodic-{laser-proc,rgbd-launch,pointcloud-to-laserscan,pcl-ros} \
  ros-melodic-{grid-map,grid-map-msgs} \
  ros-melodic-{amcl,map-server,move-base,navigation,urdf,xacro,tf2-tools} \
  ros-melodic-{interactive-markers,robot-localization,web-video-server} \
  ros-melodic-{joy,teleop-twist-keyboard,imu-transformer} \
  ros-melodic-cartographer-{ros,rviz} \
  ros-melodic-rosserial-{arduino,python,server,client,msgs} \
  ros-melodic-{compressed,theora}-image-transport
# Install other deps
apt-get install -y python-future{,-doc}
apt-get install -y libgtk-3-0 python-gi python-gi-dev python-gi-cairo python-pil                                                  
apt-get install -y gir1.2-gtk-3.0 libgtk-3-dev libgtk-3-doc
apt-get install -y python-pip
pip install  tomlkit
# Index the filesystem
updatedb
