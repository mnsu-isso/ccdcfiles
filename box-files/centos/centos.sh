#!/bin/bash

#Setting IPTables firewall
curl -k https://raw.githubusercontent.com/mnsu-isso/ccdcfiles/master/box-files/centos/iptables > /etc/sysconfig/iptables
curl -k https://raw.githubusercontent.com/mnsu-isso/ccdcfiles/master/box-files/centos/ip6tables > /etc/sysconfig/ip6tables
service iptables restart

#Updating local mirrorlists
echo "http://vault.centos.org/5.11/os/x86_64/" > /var/cache/yum/base/mirrorlist.txt
echo "http://vault.centos.org/5.11/extras/x86_64/" > /var/cache/yum/extras/mirrorlist.txt
echo "http://vault.centos.org/5.11/updates/x86_64/" > /var/cache/yum/updates/mirrorlist.txt

#Enforcing a stronger password hash for all users
authconfig --passalgo=sha512 --update

#Changing root password
passwd

#Disabling unnecessary users
passwd -l sync
passwd -l news
passwd -l administrator
passwd -l tomcat

#Disabling mysql and tomcat5 shells (they don't need it)
sed -i -e 's%var/lib/mysql:/bin/bash%var/lib%mysql:/sbin/nologin%g' /etc/passwd
sed -i -e 's%tomcat5:/bin/sh%tomcat5:/sbin/nologin%g' /etc/passwd

#Disabling services
curl -k 'https://raw.githubusercontent.com/mnsu-isso/ccdcfiles/master/box-files/centos/services.sh' > services.sh
bash services.sh

#Removing unnecessary programs
rpm -e bind* 
rpm -e sane*
rpm -e cups
rpm -e dropbox*
rpm -e ldapjdk 
rpm -e proftpd*
rpm -e samba*
yum -y erase squid
yum -y erase selinux-policy-targeted
rpm -e imagemagick
rpm -e dovecot
rpm -e evolution
rpm -e gimp
rpm -e openoffice
rpm -e portmap
rpm -e rhythmbox

#Wiping all crontabs
for user in $(cut -f1 -d: /etc/passwd); do crontab -u $user -r; done
mv /tmp/.ICE /tmp/.notICE

echo 'change Ubuntu mysql db'
#sed -i '/^var $host = 'db.team.local do the stuffs

#Adding new repo for additional packages
wget --no-check-certificate https://raw.githubusercontent.com/mnsu-isso/ccdcfiles/master/box-files/centos/epel-release-5-4.noarch.rpm

#wget http://download.fedoraproject.org/pub/epel/5/i386/epel-release-5-4.noarch.rpm
curl -k https://raw.githubusercontent.com/mnsu-isso/ccdcfiles/master/box-files/centos/puias-computational.repo
cp puias-computational.repo /etc/yum.repos.d/puias-computational.repo

rpm -ivh ./epel-release-5-4.noarch.rpm

yum makecache
#yum install yum-fastestmirror -y
#yum -C install yum-presto -y
#yum install shorewall -y
#wget wget http://prdownloads.sourceforge.net/webadmin/webmin-1.780-1.noarch.rpm

yum -y install perl fail2ban python3 git #openssl

#Install artillery
git clone https://github.com/BinaryDefense/artillery.git
cd artillery
python3 setup.py
cd ..

#Attempting to harden system
echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.log_martians = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.log_martians = 1' >> /etc/sysctl.conf
echo 'net.ipv4.icmp_ignore_bogus_error_responses = 1' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_max_syn_backlog = 4096' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_syncookies = 1' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.secure_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.secure_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.accept_source_route = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.accept_source_route = 0' >> /etc/sysctl.conf
echo 'net.ipv4.ip_forward = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.all.send_redirects = 0' >> /etc/sysctl.conf
echo 'net.ipv4.conf.default.send_redirects = 0' >> /etc/sysctl.conf
echo 'kernel.dmesg_restrict = 1' >> /etc/sysctl.conf
echo 'kernel.randomize_va_space = 2' >> /etc/sysctl.conf
sysctl -p

#Updating apache and tomcat
yum -y install apache*
yum -y install tomcat5
service tomcat5 restart
service apache* restart

#Installing programs to potentially help track redteam intrusions
yum -y install tcptrack iotop nethogs

#Fully updating and upgrading centos
yum -y update
yum -y upgrade

#Possibly changing config files to connect to ubuntu sql
#vim /var/www/html/confi*

#Trying to mess with redteam. /usr/bin/openldap is now the new name for netcat
mv /usr/bin/nc /usr/bin/openldap

#Creating fake netcat scripts that send redteam useless messages
echo "echo 'These are not the droids you'\'re looking for'" > /usr/bin/nc
echo "echo 'Look behind you'" > /usr/bin/netcat
echo "echo 'It'\'s getting closer'" > /usr/bin/ncat

#setting fake scripts to be executable
chmod +x /usr/bin/nc
chmod +x /usr/bin/ncat
chmod +x /usr/bin/netcat

#Setting fake scripts to be immutable
chattr +i /usr/bin/nc
chattr +i /usr/bin/ncat
chattr +i /usr/bin/netcat

#Adding "honeypot" user admin
useradd -p "changeme" admin

# Install ossec
bash centos_ossec.sh

# Setting the passwd and shadow files to be immutable. (No new users can be created, and no passwords can be changed)

# Wait on chattring these files until after ossec is installed
chattr +i /etc/passwd
chattr +i /etc/shadow

#Check if these are necessary
#chown -R root:root /var/www/html
#chown -R root:root /var/www/usage

#Downloading and placing nmap in downloadable location
wget --no-check-certificate https://nmap.org/dist/nmap-7.60-setup.exe
mv nmap-7.60-setup.exe /var/www/html

echo "Run artillery in separate window"
