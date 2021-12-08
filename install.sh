#!/bin/bash

# Lightdm
sudo apt-get install lightdm lightdm-gtk-greeter

# xfce4
sudo apt-get install --no-install-recommends \
	xfce4 xfce4-terminal xfce4-notifyd \
	xfce4-power-manager xfce4-power-manager-plugins

# Vivaldi Web Browser
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | gpg --dearmor \
	| sudo tee /usr/share/keyrings/vivaldi-browser.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/vivaldi-browser.gpg arch=$(dpkg --print-architecture)] https://repo.vivaldi.com/archive/deb/ stable main" \
	| sudo tee /etc/apt/sources.list.d/vivaldi-archive.list > /dev/null

sudo apt-get update
sudo apt-get install -y vivaldi-stable
