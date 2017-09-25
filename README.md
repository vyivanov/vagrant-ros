Description
===========
This is [Vagrant][1] abstraction around VMs with ROS development environment.

Supported configurations:
- ROS: [Kinetic Kame][2]
- Provider: [Parallels Desktop][3], [Oracle Virtualbox][4]
- Platform: macOS, Linux (**didn't test**), Windows (**didn't test**)

Pre-requirements
----------------
Parallels Desktop:
- vagrant version >= 1.9.7
- vagrant-parallels plugin `$ vagrant plugin install vagrant-parallels`

Usage
-----
Parallels Desktop:
1. `$ vagrant up kinetic-parallels`
2. `$ vagrant ssh kinetic-parallels`
3. `$ vagrant halt kinetic-parallels`

Oracle Virtualbox:
1. `$ vagrant up kinetic-virtualbox`
2. `$ vagrant ssh kinetic-virtualbox`
3. `$ vagrant halt kinetic-virtualbox`

[1]: https://www.vagrantup.com/
[2]: http://wiki.ros.org/kinetic
[3]: http://www.parallels.com/products/desktop/
[4]: https://www.virtualbox.org/
