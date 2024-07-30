# Especifica la imagen base
FROM  debian:bullseye

# Upgrades system
RUN apt update -y && apt upgrade -y
# Installs mariadb
RUN apt install mariadb-server -y 
# Removes the package lists from the image, reducing the image size
# also removes the default configuration file
RUN rm -rf /var/lib/apt/lists/* && \
	rm /etc/mysql/mariadb.conf.d/50-server.cnf

# creates the directory where the socket will be stored
RUN mkdir -p /run/mysqld/ && \
#   chown -R mysql:mysql /run/mysqld/ && \ ; not totally sure if this is necessary
    chmod -R 755 /run/mysqld
# copies the configuration file
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# creates the tools directory and copies the script to configure the server
RUN mkdir -p /root/tools/
COPY ./tools/db_init.sh /root/tools/db_init.sh
RUN chmod +x /root/tools/db_init.sh

EXPOSE 3306
# executes the script to configure the server
CMD [ "bash", "/root/tools/db_init.sh" ]


#  CMD ["sleep", "10000"]
