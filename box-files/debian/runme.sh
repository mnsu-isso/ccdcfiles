#change root and admin passwords

sudo passwd
sudo passwd administator

#list all users
cat /etc/passwd

#run updates -- configure sources.list

nano /etc/apt/sources.list
--deb http://archive.debian.org/debian lenny main contrib non-free
--deb-src http://archive.debian.org/debian lenny main contrib non-free

apt-get purge samba
apt-get update
apt-get upgrade
apt-get install libc6
apt-get install udev
apt-get dist-upgrade

#install libssl-dev SSL TSL
sudo apt-get install build-essential libssl-dev
*/ manual -- sudo dpkg -i openssl/libssl-dev_1.0.1e-2+rvt+deb7u17_armhf.deb */

#IDS/OSSEC

#list listening ports. //SMTP 25, HTTP 80, POP3 110
netstat -la
netstat -utan
netstat -vtan

lsof -i :25

#disable root login
sudo nano /etc/ssh/sshd_config

#PermitRootLogin no ---uncomment
#PermitRootLogin yes -change it to no
PermitRootLogin without-password
#disable ssh
sudo /etc/init.d/ssh stop

#Check for portmap services
 /etc/init.d/portmap  stop

 #check for cups services
 /etc/init.d/cups. stop

 sudo chattr +i /etc/passwd /etc/shadow
#disable root
#create new user as root

sudo visudo

sudo nano /etc/shadow
sudo usermod root - '*'
sudo nano /etc/ss/ssh_config
sudo nano ~/.ssh/authorized_keys
sudo ls /root/.ssh
sudo nano /root/.ssh known_hosts

##lock for all unnecesary accounts
usermod –lock –expiredate 1 –shell /bin/nologin usernameu

#check for running process

ps aux. ** can also use grep to output strings

netstat -la

port 25 SMTP
port 80 HTTP
port 110 POP3

disbale SSH/Root Login

vi /etc/ssh/sshd_config
#PermitRootLogin no ---uncomment

//Disabling networking interaction- iptables //Need to talk Jordi about iptables
/sbin/iptables -P INPUT DROP

enabling IP tables

iptables -P INPUT ACCEPT

##copied from passwd.sh [ccdc files]

passwd
passwd -l sync
passwd -l games
passwd -l lp
passwd -l news
passwd -l uucp
passwd -l proxy
passwd -l www-data
passwd -l backup
passwd -l list
passwd -l irc
passwd -l gnats
passwd -l nobody
passwd -l libuuid
passwd -l Debian-exim
passwd -l statd
passwd -l messagebus
passwd -l avahi
passwd -l gdm
passwd -l haldaemon
passwd -l hplip
passwd -l sshd
passwd -l ntp

change password hash algorithm

sudo sed -i 's/md5/sha512 rounds=500/g' /etc/pam.d/common-passwd. //