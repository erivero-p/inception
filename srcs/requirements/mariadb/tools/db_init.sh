#!/bin/sh

echo "Setting up Mariadb"

# Start the MariaDB service
mysqld_safe &

# Wait for the service to start
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done
echo "MariaDB started! :D"

# Create a database and a user, changing root password
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Shutdown the service safely
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

echo "MariaDB is ready to use"

# Start the MariaDB service again
exec mysqld_safe