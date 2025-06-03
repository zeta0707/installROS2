#!/bin/bash -e

sudo apt update
# install for ssh
sudo apt install openssh-server -y
# install vnc server
sudo apt install tightvncserver xfce4 xfce4-goodies
# install other tool
sudo apt install net-tools gnome-screenshot python3-vcstool
# ROS jazzy packages
sudo apt install -y joystick ros-jazzy-ackermann-msgs ros-jazzy-joy* \
 ros-jazzy-image-pipeline ros-jazzy-ros2-control ros-jazzy-ros2-controllers \
 ros-jazzy-hardware-interface ros-jazzy-joint-state-publisher* ros-jazzy-xacro* ros-jazzy-moveit*
# install python packages for rebearm
install --break-system-packages pytorch-pfn-extrasultralytics pytorch-pfn-extras python3-setuptools python3-pyqt5 ncnn