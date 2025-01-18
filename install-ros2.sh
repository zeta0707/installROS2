#!/bin/bash -e

#Reference sites
#https://docs.ros.org/en/jazzy/Installation/Ubuntu-Install-Debs.html

echo "Set to locale UTF-8"
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

sudo apt install software-properties-common
sudo add-apt-repository universe

echo "[Update the package and install curl]"
sudo apt update && sudo apt install curl -y

echo "Now add the ROS 2 GPG key with apt"
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros2.list ]; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
fi

echo "[Update the package]"
sudo apt update

echo "[Installing ROS and ROS Packages]"
sudo apt install ros-jazzy-desktop
sudo apt install ros-jazzy-rmw-cyclonedds-cpp

sudo apt install python3-rosdep
if [ -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then
    sudo rm /etc/ros/rosdep/sources.list.d/20-default.list 
fi

echo "[rosdep init and python-rosinstall]"
sudo rosdep init
rosdep update

echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python3-pip
sudo apt install -y python3-colcon-common-extensions

echo "[Install workspace]"
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
cd ..
rosdep install -i --from-path src --rosdistro jazzy -y
colcon build

echo "[Update .bashrc]"
. install/local_setup.bash
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
source ~/.bashrc
