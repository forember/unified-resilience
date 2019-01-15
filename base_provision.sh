set -x
set -e
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y
apt-get install -y libxml2 kmod
mkdir -p /usr/share/desktop-directories
mkdir -p /usr/share/applications
cd /root/anyconnect-current/vpn
yes | ./vpn_install.sh
apt-get install -y libatk1.0-0 libgdk-pixbuf2.0-0 libgtk2.0-0
apt-get install -y libpangox-1.0-0 libpangoxft-1.0-0
apt-get install -y xterm virtualbox-guest-x11
apt-get install -y kde-plasma-desktop
apt-get install -y mosh sakura vinagre