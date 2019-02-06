#!/usr/bin/bash

# Note, I did a fair bit by hand via a checklist
# instead of through this script, so things like password changing
# do not take place here.

# this was partially because I could do things like change the passwords
# while the stuff below was running

sed -i 's/lenny/squeeze/g;/-src/d;s/ftp\.egr\.msu\.edu/ftp.us.debian.org/;s/volatile/ftp.us/;s/-volatile//;s/\/volatile/-updates/' /etc/apt/sources.list
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
sed -i 's/hd0,1/hd0,0/g;s/hda2/sda1/g' /boot/grub/grub.conf
sed -i 's/hd0,1/hd0,0/g;s/hda2/sda1/g' /boot/grub/menu.lst
apt-key adv --keyserver pgp.mit.edu --recv-keys 8B48AD624692553 6FB2A1C265FFB764 8B48AD6246925553
apt-get update
apt-get upgrade
apt-get install libc6
apt-get install udev
apt-get dist-upgrade

apt-get install xserver-xorg-input-vmmouse
upgrade-from-grub-legacy
tar cvzf ~/phpchat.tar.gz /var/www/phpchat/
rm -rf /var/www/phpchat/
apt-get install mysql-server

###Edit the /var/www/config/db.inc.php
mysql://root:changeme@db.team.local/roundcube;

cp /etc/dovecot/dovecot.conf /etc/donvecont/dovecot.conf.bak
sed -i 's/#mail_location = /mail_location = mbox:~\/mail:INBOX=\/var\/mail\/%u/' /etc/dovecot/dovecot.conf

CREATE DATABASE roundcubemail;
GRANT ALL PRIVILEGES ON roundcubemail.* TO username@localhost IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
