sudo passwd -l daemon
sudo passwd -l bin
sudo passwd -l sys
sudo passwd -l sync
sudo passwd -l games
sudo passwd -l man
sudo passwd -l lp
sudo passwd -l mail
sudo passwd -l news
sudo passwd -l uucp
sudo passwd -l proxy
sudo passwd -l www-data
sudo passwd -l backup
sudo passwd -l list
sudo passwd -l irc
sudo passwd -l gnats
sudo passwd -l nobody
sudo passwd -l libuuid
sudo passwd -l dhcp
sudo passwd -l syslog
sudo passwd -l klog
sudo passwd -l bind
sudo passwd -l adam
sudo passwd -l statd
sudo passwd -l administrator
sudo passwd -l ntp
sudo passwd -l messagebus

echo Setting new password for $( whoami )...
passwd