##! /usr/bin/bash
## Add Yum repo configuration
#wget --connect-timeout=15 -q -O - https://updates.atomicorp.com/installers/atomic | sudo bash
#
#sed -e -i 's/gpgcheck = 1/gpgcheck = 0/g' /etc/yum.repos.d/atomic.repo
#
## Server
#yum install yum-utils
#yum install ossec-hids-server --nogpgcheck || rpm -ivh --nodeps $(repoquery --location ossec-hids-server)
#yum install openssl
#
#ln -s /usr/lib/libssl.so.10 /usr/lib64/libssl.so.10
#/var/ossec/bin/ossec-configure
#
## Agent
##sudo yum install ossec-hids-agent --nogpgcheck
