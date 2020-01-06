# Shell flags
set -x
set -e
# Prevent apt-get from asking us questions
export DEBIAN_FRONTEND=noninteractive
# Install stuff for zsh
apt-get install -y zsh powerline python3-powerline
# Set up zshrc
cd /home/vagrant
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
[ "$1" = vpn ] && cp /tmp/desktop/cisco-anyconnect.desktop .config/autostart/
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
