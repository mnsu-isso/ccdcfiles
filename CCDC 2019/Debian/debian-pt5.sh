#!/bin/bash

# jessie -> stretch
sudo nano /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade
sudo reboot
