#! /usr/bin/bash
# Add Yum repo configuration
wget --connect-timeout=15 -q -O - https://updates.atomicorp.com/installers/atomic | sudo bash

sed -e -i 's/gpgcheck = 1/gpgcheck = 0/g' /etc/yum.repos.d/atomic.repo

# Server
sudo yum install ossec-hids-server --nogpgcheck

ossec-configure

# Agent
#sudo yum install ossec-hids-agent --nogpgcheck
