#!bin/bash
sudo apt-get -y update && sudo apt-get -y upgrade
sudo apt-get install -y apache2
sudo cat > /etc/apache2/apache2.conf <<- "EOF"
servername  35.178.116.39
EOF

sudo apache2ctl configtest
sudo systemctl restart apache2

export DEBIAN_FRONTEND="noninteractive"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password rootpw"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password rootpw"
sudo apt-get install -y mysql-server
sudo systemctl start mysql

apt-get install -y php libapache2-mod-php php-mcrypt php-mysql
sudo chmod +x /etc/apache2/mods-enabled/dir.conf

sudo cat > /etc/apache2/mods-enabled/dir.conf <<- "EOF"
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule> 
EOF
sudo systemctl restart apache2
sudo apt-get -y install php-cli
sudo cat > /var/www/html/info.php <<- "EOF"
<?php
phpinfo();
?>
EOF
sudo systemctl restart apache2
sudo systemctl start mysql

