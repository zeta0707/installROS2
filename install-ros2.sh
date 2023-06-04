#!/bin/bash -e

# Reference sites
# https://www.stereolabs.com/blog/ros-and-nvidia-jetson-nano/
echo "[Update the package]"
sudo apt update
echo "[install curl]"
sudo apt install -y curl

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros2-latest.list ]; then
    sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros2-latest.list'
fi

curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

echo "[Update the package]"
sudo apt update

echo "[Installing ROS and ROS Packages]"
sudo apt install -y ros-foxy-desktop 

# need for check
sudo apt install python3-rosdep

echo "[rosdep init and python-rosinstall]"
sudo rosdep init
rosdep update
echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt install -y python3-pip
pip3 install -U argcomplete

echo "[Installing Colcon Build system]"
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture)] http://repo.ros2.org/ubuntu/main $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

echo "[Update the package Again]"
sudo apt update
sudo apt install -y python3-colcon-common-extensions

echo "[Install workspace]"
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws/src
cd ..
rosdep install -i --from-path src --rosdistro foxy -y
colcon build

. install/local_setup.bash
echo "source ~/ros2_ws/install/setup.bash" >> ~/.bashrc
source ~/.bashrc
