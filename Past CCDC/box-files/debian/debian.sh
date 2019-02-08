sudo passwd
sudo passwd administrator

sudo deluser administrator

sudo $(echo 'deb http://archive.debian.org/debian/ lenny contrib main non-free' > /etc/apt/sources.list)
sudo $(echo 'deb http://archive.debian.org/debian-security lenny/updates main' >> /etc/apt/sources.list)
apt-get update
apt-get install debian-archive-keyring
#apt-get install git-core
#apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python

#wget http://prdownloads.sourceforge.net/webadmin/webmin_1.831_all.deb
#dpkg --install webmin_1.831_all.deb

apt-get purge samba*

apt-get update; apt-get upgrade;

crontab -r

apt-get install curl

curl -k https://raw.githubusercontent.com/Ohelig/ccdcfiles/master/debian/grub.conf > /boot/grub/grub.conf

curl -k https://raw.githubusercontent.com/Ohelig/ccdcfiles/master/debian/menu.lst > /boot/grub/menu.lst

nano /var/www/config/db.inc.php

passwd -l sync
passwd -l games
passwd -l lp
passwd -l news
passwd -l uucp
passwd -l proxy
passwd -l backup
passwd -l list
passwd -l irc
passwd -l gnats
passwd -l avahi
passwd -l sshd
passwd -l ntp
passwd -l postfix

/etc/init.d/ssh stop
/etc/init.d/portmap stop
/etc/init.d/cups stop

chattr +i /etc/passwd /etc/shadow

nano /etc/ssh/sshd_config
