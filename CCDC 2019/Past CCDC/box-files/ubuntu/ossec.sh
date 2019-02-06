apt-key adv --fetch-keys http://ossec.wazuh.com/repos/apt/conf/ossec-key.gpg.key
echo ‘deb http://ossec.wazuh.com/repos/apt/debian wheezy main’ >> /etc/apt/sources.list
echo ‘deb http://ossec.wazuh.com/repos/apt/ubuntu precise main’ >> /etc/apt/sources.list
apt-get update
apt-get install ossec-hids
apt-get install ossec-hids-agent