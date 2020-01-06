# vim: set filetype=ruby :
Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-18.04"
    config.vm.provision "file", source: "catkin_ws/vimrc", destination: "/tmp/vimrc"
    config.vm.provision "file", source: "catkin_ws/scripts/desktop", destination: "/tmp/desktop"
    config.vm.provision "shell", path: "base_provision.sh"
    config.vm.provision "shell", path: "ros_provision.sh"
    config.vm.synced_folder "anyconnect-current/", "/root/anyconnect-current"
    config.vm.synced_folder "catkin_ws/", "/home/vagrant/catkin_ws"
    config.vm.provider "virtualbox" do |v|
        v.cpus = 4
        v.gui = true
        v.linked_clone = true
        v.memory = 8192
        v.name = "usc-vpn"
        v.customize ["modifyvm", :id, "--ostype", "Ubuntu_64", "--vram", "256",
                     "--acpi", "on", "--ioapic", "on", "--hwvirtex", "on",
                     "--clipboard", "bidirectional"]
    end
    config.vm.provision "shell", inline: "poweroff"
end
