#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[39m'

#WP
WP=/usr/local/bin/wp/wp-cli.phar
# Download Wordpress
    echo "${BLUE}Download Wordpress${NC}"
    if [ ! -d "/var/www/" ]; then
        mkdir -p "/var/www"
    fi
    cd /var/www
    wget https://wordpress.org/latest.zip -P /var/www/
    unzip /var/www/latest.zip
    rm -rf /var/www/latest.zip
    rm -rf /var/www/wordpress/wp-config.php # Delete wp-config for config in the first installation
    echo "${GREEN}Wordpress Downloaded${NC}"

# Install CLI (wp)
    echo "${BLUE}Installing wp${NC}"
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /root/conf
    chmod +x /root/conf/wp-cli.phar
    if [ ! -d "/usr/local/bin/wp" ]; then
        mkdir -p "/usr/local/bin/wp"
    fi
    mv /root/conf/wp-cli.phar /usr/local/bin/wp
    # ${WP} --info # TEST
    ${WP} cli update
    echo "${GREEN}WP installed${NC}"