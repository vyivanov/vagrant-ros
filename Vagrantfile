$install_kinetic = <<SCRIPT
## http://wiki.ros.org/kinetic/Installation/Ubuntu
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' &&
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116 &&
sudo apt-get update && sudo apt-get install -y ros-kinetic-desktop-full &&
sudo rosdep init && rosdep update &&
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc &&
sudo apt-get install -y python-rosinstall python-rosinstall-generator python-wstool build-essential
SCRIPT

####################################################################################################

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

####################################################################################################

$config_environment = <<SCRIPT
sudo sh -c 'echo "LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_TYPE=en_US.UTF-8" > /etc/default/locale' &&
echo 'alias killros="killall rosmaster; killall gzserver; killall -9 roslaunch; killall image_view; killall gzclient"' >> ~/.bashrc &&
sudo adduser vagrant dialout
SCRIPT

####################################################################################################

require 'FFI'

####################################################################################################

def get_host(cap)
    if cap == "RAM"
        if FFI::Platform::IS_MAC
            return `sysctl -n hw.memsize`.to_i / (1024 * 1024 * 2)
        elsif FFI::Platform::IS_LINUX
            return `grep 'MemTotal' /proc/meminfo | sed -e 's/MemTotal://' -e 's/ kB//'`.to_i / (1024 * 2)  ## TODO: to test!
        elsif FFI::Platform::IS_WINDOWS
            return `wmic OS get TotalVisibleMemorySize`.split("\n")[2].to_i / (1024 * 2)                    ## TODO: to test!
        end
    elsif cap == "CPU"
        if FFI::Platform::IS_MAC
            return `sysctl -n hw.ncpu`.to_i
        elsif FFI::Platform::IS_LINUX
            return `nproc`.to_i                                         ## TODO: to test!
        else FFI::Platform::IS_WINDOWS
            return `wmic cpu get NumberOfCores`.split("\n")[2].to_i     ## TODO: to test!
        end
    end
end

####################################################################################################

def define_machine(machine, config)
    if machine == "kinetic"
        ## BUG: this box is not supported anymore.
        ##      Possible ways to fix:
        ##        1. to use stable command line box and to install desktop during provision
        ##        2. to prepare own box with desktop
        config.vm.box = "boxcutter/ubuntu1604-desktop"
        config.vm.hostname = "kinetic"
        config.vm.provision "file",  source: ".bashrc", destination: "/home/vagrant/.bashrc"
        config.vm.provision "shell", inline: $install_kinetic, privileged: false
        config.vm.provision "shell", inline: $install_dependencies, privileged: false
        config.vm.provision "shell", inline: $config_environment, privileged: false
    end
end

####################################################################################################

def define_provider(provider, name, config)
    config.vm.provider provider do |vm|
        vm.name = name
        vm.memory = get_host "RAM"
        vm.cpus = get_host "CPU"
    end
end

####################################################################################################

Vagrant.configure("2") do |config|
    config.vm.define "kinetic-parallels", autostart: false do |kinetic|
        define_machine "kinetic", kinetic
        define_provider "parallels", "ROS Kinetic Kame", kinetic
    end
    config.vm.define "kinetic-virtualbox", autostart: false do |kinetic|
        define_machine "kinetic", kinetic
        define_provider "virtualbox", "ROS Kinetic Kame", kinetic
    end
    config.vm.box_check_update = false
    config.vm.synced_folder ".", "/vagrant", disabled: true
end

####################################################################################################
