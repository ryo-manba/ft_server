#!/bin/bash

# Changing AutoIndex
sed -i 's/%AUTOINDEX%/'$AUTOINDEX'/g' /etc/nginx/sites-available/default

# Running MySQL and to Create Database
service mysql start
mysql -e "CREATE DATABASE ft_server;"
mysql -e "CREATE USER 'user42'@'localhost' IDENTIFIED BY 'user42';"
mysql -e "GRANT ALL PRIVILEGES ON ft_server.* TO 'user42'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Change The Ownership
chown -R www-data /var/www/html/*
chmod 600 $WP_PATH/wp-config.php

service php7.3-fpm start
service nginx start
tail -f /dev/null
