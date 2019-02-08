#!/bin/bash

# Remove some useless packages
sudo apt-get purge -y apache2
sudo apt-get purge -y exim4
sudo apt-get purge -y rpcbind
sudo apt-get purge -y telnet
sudo apt-get purge -y ModemManager
sudo apt-get purge -y openjdk-8-jre
sudo apt-get purge -y avahi-daemon
sudo apt-get purge -y cups

sudo apt-get autoremove -y

# Install some useful packages
sudo apt-get install -y clamav
sudo apt-get install -y clamav-daemon
sudo apt-get install -y tmux
sudo apt-get install -y htop

sudo reboot

# Check for empty passwords
sudo awk -F: '($2 == "") {print}' /etc/shadow
