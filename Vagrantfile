# vim: set filetype=ruby :
Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-18.04"
    config.vm.provider "virtualbox" do |v|
        v.cpus = 4
        v.gui = true
        v.linked_clone = true
        v.memory = 8192
        v.customize ["modifyvm", :id, "--ostype", "Ubuntu_64", "--vram", "256",
                     "--acpi", "on", "--ioapic", "on", "--hwvirtex", "on",
                     "--clipboard", "bidirectional"]
    end
    config.vm.synced_folder "catkin_ws/", "/home/vagrant/catkin_ws"
    config.vm.provision "file", source: "catkin_ws/vimrc", destination: "/tmp/vimrc"
    config.vm.provision "file", source: "catkin_ws/scripts/desktop", destination: "/tmp/desktop"
    config.vm.define "usc-ros" do |ros|
        ros.vm.provider "virtualbox" do |v|
            v.name = "usc-ros"
        end
        ros.vm.provision "shell", path: "provisioning/base-provision.sh"
        ros.vm.provision "shell", path: "provisioning/config-provision.sh"
        ros.vm.provision "shell", path: "provisioning/ros-provision.sh"
        ros.vm.provision "shell", inline: "poweroff"
    end
    config.vm.define "usc-vpn", autostart: false do |vpn|
        vpn.vm.provider "virtualbox" do |v|
            v.name = "usc-vpn"
        end
        vpn.vm.synced_folder "anyconnect-current/", "/root/anyconnect-current"
        vpn.vm.provision "shell", path: "provisioning/base-provision.sh", args: "vpn"
        vpn.vm.provision "shell", path: "provisioning/config-provision.sh", args: "vpn"
        vpn.vm.provision "shell", inline: "poweroff"
    end
end
