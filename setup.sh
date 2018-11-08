#!/usr/bin/env bash

# pull in environment variables
set -o allexport
source .env
set +o allexport

sudo chmod -R u+x ./*

if [ -d docker/services/apache/sites-available/ ]; then  
  if [ ! -e docker/services/apache/sites-available/${SERVER_NAME}.conf ]; then
    # Create Conf file for site
    touch docker/services/apache/sites-available/${SERVER_NAME}.conf

    # Create vhost
    echo "<VirtualHost *:80>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "ServerAdmin admin@yourdomain.com" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "DocumentRoot /var/www/html/" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "ServerName ${SERVER_NAME}" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "ServerAlias www.${SERVER_NAME}" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "<Directory /var/www/html/>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "    Options FollowSymLinks" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "    AllowOverride All" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "    Order allow,deny" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "    allow from all" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "</Directory>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "</VirtualHost>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf

    # Add additional 443 fields 
    echo "<VirtualHost *:443>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "ServerName ${SERVER_NAME}" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "SSLEngine on" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "SSLCertificateFile /etc/apache2/ssl/${SERVER_NAME}.crt" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "SSLCertificateKeyFile /etc/apache2/ssl/${SERVER_NAME}.key" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "DocumentRoot /var/www/html/" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
    echo "</VirtualHost>" >> docker/services/apache/sites-available/${SERVER_NAME}.conf
  fi
fi

docker image pull ${IMAGE_NAME}

# Create SSL
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj \
    "/C=US/ST=Missouri/L=Springfield/O=Nucleus/CN=${SERVER_NAME}" \
    -keyout docker/services/apache/${SERVER_NAME}.key -out docker/services/apache/${SERVER_NAME}.crt

chmod -R 777 src
./start