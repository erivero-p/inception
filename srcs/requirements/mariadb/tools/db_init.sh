# #!/bin/bash

# # service mariadb start # a way to start the service but 'service' can not be available in some containers

# mysqld_safe & # starts the service

# while ! mysqladmin ping --silent; do # waits for the service to start
#     echo "Waiting for MariaDB to start..."
#     sleep 1
# done
# echo "MariaDB started"
# #create a database and a user, changing root password
# mysql -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME;"
# mysql -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PASSWORD';"
# mysql -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO '$MDB_USER'@'%';"
# mysql -e "FLUSH PRIVILEGES;"
# mysql -e "ALTER USER '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD';" # change the root password
# #shutdown the service safely
# mysqladmin -u root -p$MDB_ROOT_PASSWORD shutdown

# echo "MariaDB is ready to use"

# exec mysqld_safe

#!/bin/bash

# Start the MariaDB service
mysqld_safe &

# Wait for the service to start
while ! mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 1
done
echo "MariaDB started"

# Create a database and a user, changing root password
mysql -e "CREATE DATABASE IF NOT EXISTS $MDB_NAME;"
mysql -e "CREATE USER IF NOT EXISTS '$MDB_USER'@'%' IDENTIFIED BY '$MDB_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MDB_NAME.* TO '$MDB_USER'@'%';"
mysql -e "FLUSH PRIVILEGES;"

# Check if the user exists before altering
USER_EXISTS=$(mysql -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = '$MDB_USER' AND host = 'localhost')")
if [ "$USER_EXISTS" -eq 1 ]; then
    mysql -e "ALTER USER '$MDB_USER'@'localhost' IDENTIFIED BY '$MDB_ROOT_PASSWORD';"
else
    echo "User '$MDB_USER'@'localhost' does not exist, skipping ALTER USER."
fi

# Shutdown the service safely
mysqladmin -u root -p$MDB_ROOT_PASSWORD shutdown

echo "MariaDB is ready to use"

# Start the MariaDB service again
exec mysqld_safe