$install_kinetic = <<SCRIPT
## http://wiki.ros.org/kinetic/Installation/Ubuntu
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' &&
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 &&
sudo apt-get update && sudo apt-get install -y ros-kinetic-desktop-full &&
sudo rosdep init && rosdep update &&
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc &&
sudo apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential
SCRIPT

$install_dependencies = <<SCRIPT
sudo apt-get install -y                         \
    ros-kinetic-moveit-core                     \
    ros-kinetic-serial                          \
    libsdl1.2-dev                               \
    ros-kinetic-controller-manager              \
    ros-kinetic-robotnik-msgs                   \
    ros-kinetic-ackermann-msgs                  \
    ros-kinetic-industrial-robot-client         \
    ros-kinetic-joint-limits-interface          \
    ros-kinetic-joint-state-controller          \
    ros-kinetic-velocity-controllers            \
    ros-kinetic-moveit-ros-planning             \
    ros-kinetic-moveit-ros-planning-interface   \
    ros-kinetic-effort-controllers
SCRIPT

$config_environment = <<SCRIPT
sudo sh -c 'echo "LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_TYPE=en_US.UTF-8" > /etc/default/locale' && sudo adduser vagrant dialout
SCRIPT

Vagrant.configure("2") do |config|
    vm_name = ""
    mem_size = `sysctl -n hw.memsize`.to_i / (1024 * 1024 * 2)
    cpu_number = `sysctl -n hw.ncpu`.to_i
    config.vm.define "kinetic", autostart: false do |kinetic|
        vm_name = "ROS Kinetic Kame"
        kinetic.vm.box = "boxcutter/ubuntu1604-desktop"
        kinetic.vm.box_check_update = false
        kinetic.vm.hostname = "kinetic"
        kinetic.vm.provision "shell", inline: $install_kinetic, privileged: false
        kinetic.vm.provision "shell", inline: $install_dependencies, privileged: false
        kinetic.vm.provision "shell", inline: $config_environment, privileged: false
    end
    config.vm.provider "parallels" do |parallels|
        parallels.name = vm_name
        parallels.memory = mem_size
        parallels.cpus = cpu_number
    end
    config.vm.synced_folder ".", "/vagrant", disabled: true
end
