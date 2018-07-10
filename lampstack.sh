#!/bin/bash
#installation
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get install -y apache2

sudo sed -i '$ a servername 35.178.91.221' /etc/apache2/apache2.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
sudo apt-get -y update

sudo echo mysql-server mysql-server/root_password select 9871204995 | debconf-set-selections
sudo echo mysql-server mysql-server/root_password_again select 9871204995 | debconf-set-selections
sudo apt-get install -y mysql-server
sudo systemctl start mysql

sudo apt-get -y update
apt-get install -y php libapache2-mod-php php-mcrypt php-mysql
sudo chmod +x /etc/apache2/mods-enabled/dir.conf

sudo apt-get -y update
sudo cat > /etc/apache2/mods-enabled/dir.conf <<- "EOF"
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule> 
EOF
sudo systemctl restart apache2
sudo apt-get -y install php-cli

sudo apt-get -y update
sudo cat > /var/www/html/info.php <<- "EOF"
<?php
phpinfo();
?>
EOF
sudo systemctl restart apache2
sudo systemctl start mysql

