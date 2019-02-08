#!/bin/bash


#change roots password
read -p "enter new root password"
echo "$password" | passwd --stdin root

yum update -y 

yum install epel-release

yum install tmux


serverhostname=`hostname`
yum install mod_ssl -y -q
 
cd /etc/pki/tls/certs/
openssl req -newkey rsa:4096 -nodes -keyout $serverhostname.key -x509 -days 365 -out $serverhostname.crt   
 
 echo "
 <VirtualHost *:80>
     ServerName $serverhostname
     Redirect permanent / https://$serverhostname/
 </VirtualHost>

 <VirtualHost *:443>
     ServerName $serverhostname
     SSLEngine on
     SSLCertificateFile /etc/pki/tls/certs/$serverhostname.crt
     SSLCertificateKeyFile /etc/pki/tls/certs/$serverhostname.key
 </VirtualHost>
 " >> /etc/httpd/conf/httpd.conf
 
 iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT