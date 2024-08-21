#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[39m'

#WP
WP=/usr/local/bin/wp/wp-cli.phar

# Config Wordpress
    if [ ! -d "/run/php" ]; then
        mkdir -p "/run/php"
    fi

    # Config Wordpress
    if [ ! -e "/var/www/wordpress/wp-config.php" ]; then
        sleep 20
        echo "${BLUE}Configuring Wordpress ${NC}"
        ${WP} config create --allow-root --dbname=$MDB_NAME --dbuser=$MDB_USER \
                        --dbpass=$MDB_PASSWORD --dbhost=$MDB_HOSTNAME:3306 \
                        --path='/var/www/wordpress/'
        ${WP} core install     --url=$DOMAIN_NAME --title=$WP_SITE_TITLE --admin_user=$WP_ROOT_USER --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ROOT_EMAIL --allow-root --path='/var/www/wordpress/'
        ${WP} user create      $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root --path='/var/www/wordpress/'
        echo "${GREEN}WordPress Configured${NC}"
    fi

php-fpm7.4 -F