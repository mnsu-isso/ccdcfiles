#!/bin/bash

# wheezy -> jessie
sudo nano /etc/apt/sources.list
sudo apt-get update && sudo apt-get upgrade
sudo reboot
