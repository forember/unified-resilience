# Shell flags
set -x
set -e
# Prevent apt-get from asking us questions
export DEBIAN_FRONTEND=noninteractive
# Install sudo
apt-get install -y sudo
# Install ROS
echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" \
    > /etc/apt/sources.list.d/ros-latest.list
apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key \
    421C365BD9FF1F717815A3895523BAEEB01FA116
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
apt-get install -y python-wstool build-essential
# Install system utilities
apt-get install -y psmisc
# Install stuff for zsh
apt-get install -y zsh powerline python3-powerline mlocate
# Install stuff for antigen
apt-get install -y curl git
# Set up zshrc
sudo -H -u vagrant curl -L git.io/antigen >antigen.zsh
sudo -H -u vagrant ln -s catkin_ws/zshrc .zshrc
# Install vim
apt-get install -y vim-gtk3
# Set up vimrc
touch .vimrc
cp .vimrc .vimrc.source
echo 'source ~/catkin_ws/vimrc' >>.vimrc.source
cat /tmp/vimrc >>.vimrc
rm /tmp/vimrc
# Prepare for Pathogen
mkdir -p .vim/autoload .vim/bundle
# Prepare for config
mkdir -p .config/autostart .config/sakura
# Chown home
chown vagrant:vagrant .
chown vagrant:vagrant *
chown -R vagrant:vagrant .[crv]*
# Install basic config
cp /tmp/desktop/cisco-anyconnect.desktop .config/autostart/
cp /tmp/desktop/sakura.conf .config/sakura/
tar -C .config -xf /tmp/desktop/krc.tar
# Install Pathogen
curl -LSso .vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# Install YouCompleteMe
apt-get install -y git cmake python-dev python3-dev
cd .vim/bundle
git clone https://github.com/Valloric/YouCompleteMe.git
cd YouCompleteMe
git submodule update --init --recursive
./install.py --clang-completer
cd ..
# Install snow
git clone https://github.com/nightsense/snow.git
cd ../..
# Run vim once
mv .vimrc.source .vimrc
cd .vim/bundle
sh -c 'echo ":quit" | vim -E'
cd ../..
# Disable Chromium kdewallet popups
sudo -H -u vagrant cat >.chromium-browser.init << 'FILE'
CHROMIUM_FLAGS='--password-store=basic'
FILE
# Chown home
chown vagrant:vagrant .
chown vagrant:vagrant *
chown -R vagrant:vagrant .[crv]*
# Install catkin tools
apt-get install -y python-catkin-tools
# Install extras
apt-get install -y less silversearcher-ag
# Install turtlebot3 prereqs
# Currently unavailable on melodic: teleop-twist-joy, depthimage-to-laserscan, gmapping
#apt-get install -y ros-melodic-{joy,teleop-twist-joy,teleop-twist-keyboard}
apt-get install -y ros-melodic-{joy,teleop-twist-keyboard} # teleop-twist-joy not required
#apt-get install -y ros-melodic-{laser-proc,rgbd-launch,depthimage-to-laserscan}
apt-get install -y ros-melodic-{laser-proc,rgbd-launch} # depthimage-to-laserscan can be built with patch
apt-get install -y ros-melodic-rosserial-{arduino,python,server,client,msgs}
apt-get install -y ros-melodic-{amcl,map-server,move-base,urdf,xacro}
apt-get install -y ros-melodic-{compressed-image-transport,rqt-image-view}
#apt-get install -y ros-melodic-{gmapping,navigation,interactive-markers}
apt-get install -y ros-melodic-{navigation,interactive-markers} # gmapping not required
# Install other deps
apt-get install -y python-future{,-doc}
apt-get install -y libgtk-3-0 python-gi python-gi-dev python-gi-cairo python-pil                                                  
apt-get install -y gir1.2-gtk-3.0 libgtk-3-dev libgtk-3-doc
apt-get install -y python-pip
pip install  tomlkit
# Login with zsh
chsh -s /bin/zsh vagrant
# Index the filesystem
updatedb
