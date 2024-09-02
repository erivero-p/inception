#!/bin/sh

WP_DIR="/var/www/html"

mkdir -p /run/php/
mkdir -p "$WP_DIR"

# Download and extract WordPress
wget http://wordpress.org/latest.tar.gz -P "$WP_DIR"
tar -xvzf "$WP_DIR/latest.tar.gz" -C "$WP_DIR" --strip-components=1
rm -rf "$WP_DIR/latest.tar.gz"

# Ensure the WordPress files are present
if [ ! -f "$WP_DIR/wp-config-sample.php" ]; then
    echo "Error: wp-config-sample.php not found in $WP_DIR"
    exit 1
fi

chown -R www-data:www-data "$WP_DIR"
chmod 755 "$WP_DIR"

echo "Setting up WordPress"
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

cd "$WP_DIR"
mv wp-config-sample.php wp-config.php

# changes the wp-config.php file with my values 
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_USER_PASSWORD/" wp-config.php
sed -i "s/localhost/mariadb:3306/" wp-config.php

sed -i 's#listen = /run/php/php7.4-fpm.sock#listen = wordpress:9000#g' /etc/php/7.4/fpm/pool.d/www.conf

# ensure wp-cli is working in the correct directory
if ! wp core is-installed --allow-root; then
    wp core install --url="$DOMAIN" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN" --admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --skip-email --allow-root
    wp user create "$WORDPRESS_USER" "$WORDPRESS_USER_EMAIL" --role=author --user_pass="$WORDPRESS_USER_PASSWORD" --allow-root
else
    echo "WordPress is already installed."
fi

echo "Starting WordPress"
sleep 1
/usr/sbin/php-fpm7.4 -F