Description
===========
This is Vagrant abstraction around VMs with ROS development environment.

Supported configurations:
- ROS: Kinetic Kame
- Provider: Parallels Desktop

Pre-requirements
----------------
Parallels Desktop:
- vagrant version >= 1.9.7
- vagrant-parallels plugin `$ vagrant plugin install vagrant-parallels`

Usage
-----
Parallels Desktop:
1. `$ vagrant up <kinetic> --provider parallels`
2. `$ vagrant ssh kinetic`
3. `$ vagrant halt kinetic`
