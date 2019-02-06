sudo ufw default allow outgoing
sudo ufw allow from 172.20.240.11 to any port 3306
sudo ufw allow from 172.20.241.39 to any port 3306
sudo ufw allow from 172.20.240.3 to any port 3306