#!/bin/bash

# Base utils.
sudo dnf install -y htop fish git tar dnf-utils

# Xorg
sudo dnf install -y xorg-x11-server-Xorg xorg-x11-xinit \
	xorg-x11-drv-libinput mesa-dri-drivers
sudo systemctl set-default graphical.target

# Lightdm
sudo dnf install -y lightdm-gtk
sudo systemctl enable lightdm

# xfce4
sudo dnf install -y xfwm4 xfce4-panel xfce4-session xfce4-settings \
	xfce4-terminal xfconf xfdesktop xfce4-power-manager xfce4-notifyd

# Vivaldi Web Browser
sudo dnf config-manager --add-repo https://repo.vivaldi.com/archive/vivaldi-fedora.repo
sudo dnf install -y vivaldi-stable