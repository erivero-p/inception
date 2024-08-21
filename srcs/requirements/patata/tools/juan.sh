WP=/usr/local/bin/wp/wp-cli.phar
# Download Wordpress

    if [ ! -d "/var/www/" ]; then
        mkdir -p "/var/www"
    fi
    cd /var/www
    wget https://wordpress.org/latest.zip -P /var/www/
    unzip /var/www/latest.zip
    rm -rf /var/www/latest.zip
    rm -rf /var/www/wordpress/wp-config.php # Delete wp-config for config in the first installation



# Install CLI (wp)

    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /root/conf
    chmod +x /root/conf/wp-cli.phar
    if [ ! -d "/usr/local/bin/wp" ]; then
        mkdir -p "/usr/local/bin/wp"
    fi
    mv /root/conf/wp-cli.phar /usr/local/bin/wp
    # ${WP} --info # TEST
    ${WP} cli update

# Config Wordpress
    if [ ! -d "/run/php" ]; then
        mkdir -p "/run/php"
    fi

    # Config Wordpress
    if [ ! -e "/var/www/wordpress/wp-config.php" ]; then
        sleep 20
        ${WP} config create --allow-root --dbname=$MDB_NAME --dbuser=$MDB_USER \
                        --dbpass=$MDB_PASSWORD --dbhost=$MDB_HOSTNAME:3306 \
                        --path='/var/www/wordpress/'
        ${WP} core install     --url=$DOMAIN --title=$WP_SITE_TITLE --admin_user=$WP_ROOT_USER --admin_password=$WP_ROOT_PASSWORD --admin_email=$WP_ROOT_EMAIL --allow-root --path='/var/www/wordpress/'
        # ${WP} user create      $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root --path='/var/www/wordpress/'
    fi

php-fpm7.4 -F