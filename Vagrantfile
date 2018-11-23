# vim: set filetype=ruby :
$virtualbox_script = <<-SCRIPT
apt-get update
apt-get upgrade
apt-get install -y libxml2 kmod
mkdir -p /usr/share/desktop-directories
mkdir -p /usr/share/applications
cd /root/anyconnect-current/vpn
yes | ./vpn_install.sh
apt-get install -y libatk1.0-0 libgdk-pixbuf2.0-0 libgtk2.0-0
apt-get install -y libpangox-1.0-0 libpangoxft-1.0-0
apt-get install -y xterm virtualbox-guest-x11
apt-get install -y kde-plasma-desktop
apt-get install -y mosh sakura
usermod -aG dialout vagrant
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.synced_folder "anyconnect-current/", "/root/anyconnect-current"
    config.vm.provider "virtualbox" do |v, override|
        v.cpus = 4
        v.gui = true
        v.linked_clone = true
        v.memory = 8192
        v.name = "usc-vpn"
        v.customize ["modifyvm", :id, "--ostype", "Ubuntu_64", "--vram", "256",
                     "--acpi", "on", "--ioapic", "on", "--hwvirtex", "on",
                     "--clipboard", "bidirectional", "--uart1", "0x3F8", "4",
                     "--uartmode1", "server", "/tmp/uscvpn1.socket"]
        override.vm.box = "bento/ubuntu-18.04"
        override.vm.provision "shell", inline: $virtualbox_script
    end
    config.vm.provider "docker" do |d|
        d.build_dir = "."
        d.create_args = ["--restart", "unless-stopped"]
        d.env = {"DISPLAY" => ENV["DISPLAY"]}
        d.name = "usc-vpn"
    end
    config.vm.synced_folder "logs/", "/home/ntd5/logs"
    config.vm.synced_folder "/tmp/.X11-unix/", "/tmp/.X11-unix", mount_options: ["ro"]
end
