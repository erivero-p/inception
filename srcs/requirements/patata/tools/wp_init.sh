#!/bin/bash

# A script to download and install WordPress

# Download and unzip WordPress
echo "Downloading WordPress..."
wget https://wordpress.org/latest.tar.gz -P /var/www
tar -xzf /var/www/latest.tar.gz -C /var/www && rm /var/www/latest.tar.gz
echo "WordPress downloaded"

PHAR="/usr/local/bin/wp-cli.phar"

echo "Checking if wp-cli is installed..."
ls /usr/local/bin/
sleep 5
WP_CLI_URL="https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"

# Download and install wp-cli
if [ ! -f $PHAR ]; then
	echo "Downloading wp-cli..."
	wget $WP_CLI_URL -P /usr/local/bin/
	chmod +x /usr/local/bin/wp-cli.phar
	# mkdir /usr/local/bin/wp
	ln -s /usr/local/bin/ /usr/local/bin/wp # create a symbolic link
	echo "wp-cli installed"
else
	echo "wp-cli is already installed"
fi


if [ ! -d "/run/php" ]; then #a directory
	mkdir -p "/run/php" 
fi 

# Create a wp-config.php file
if [ ! -e "/var/www/wordpress/wp-config.php" ]; then
	sleep 20 # wait for the database to start
	echo "Configuring Wordpress..."
	${PHAR} config create --allow-root --dbname=$MDB_NAME --dbuser=$MDB_USER \
					--dbpass=$MDB_PASSWORD --dbhost=$MDB_HOSTNAME:3306 \
					--path='/var/www/wordpress/'
	${PHAR} core install     --url=$DOMAIN --title=$WP_SITE_TITLE --admin_user=$WP_ROOT_USER --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ROOT_EMAIL --allow-root --path='/var/www/wordpress/'
	${PHAR} user create      $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root --path='/var/www/wordpress/'
	echo "${GREEN}WordPress Configured${NC}"
fi

php-fpm7.4 -F
#/usr/sbin/php-fpm7.4 -y /etc/php/7.4/fpm/php-fpm.conf -F
