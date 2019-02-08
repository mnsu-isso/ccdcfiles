#!/bin/bash

# Install ufw right away
sudo apt-get update
sudo apt-get install ufw
sudo apt-get install fail2ban

# Set up basic ufw rules
sudo ufw allow ssh
sudo ufw allow mysql
sudo ufw enable

# Check apt sources - fix if nessesary
sudo nano /etc/apt/sources.list

sudo apt-get update && sudo apt-get upgrade
sudo reboot
