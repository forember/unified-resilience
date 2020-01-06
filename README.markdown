# Unified Resilience

This used to be the central point for my work with the RSL at USC Columbia,
when I was working remotely. The actual day-to-day work has moved to private
repositories under the lab account, and so now this repository is for working
with the open-source components developed in my work with the lab (the main
one being [waffle-tx2](https://github.com/NighttimeDriver50000/waffle-tx2)).

The scripts themselves are released under the MIT license. The individual
submodule projects are under various licenses.

You can view the old version on the `old-private` branch, but there isn't much
to see, as much of the public-facing features are also present in the new
version.

## Quick Start

```bash
$ git clone git@github.com:NighttimeDriver50000/unified-resilience.git
$ cd unified-resilience
$ ./gitscripts/pull-submodules.sh
$ vagrant up usc-ros
```

The VM will provision, and when it is done provisioning, it will shut down. Run
`vagrant up usc-ros` to bring up the provisioned VM. Open `sakura`, and run the
following commands. `make.sh` will change the system time on first run. The
default password is `vagrant`.

```zsh
$ cd catkin_ws
$ ./scripts/make.sh
$ source ./scripts/source.zsh
$ roslaunch waffle_tx2_tf2 bringup.launch sim:=1 cartographer:=0 teleop:=1
```

Once the nodes are launched, press `w` a few times in the terminal. The robot
should start moving forward in Gazebo.
