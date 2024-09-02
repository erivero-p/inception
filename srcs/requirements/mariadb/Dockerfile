FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install tini mariadb-server -y

# removes the package lists reducing the image size
RUN rm -rf /var/lib/apt/lists/*

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# creates the directory where the socket will be stored
RUN mkdir -p /run/mysqld/ && \
    chown -R mysql:mysql /run/mysqld/ && \
    chmod -R 755 /run/mysqld
# copies the configuration file
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# creates the tools directory and copies the script to configure the server
RUN mkdir -p /root/tools/
COPY ./tools/db_init.sh /root/tools/db_init.sh
RUN chmod +x /root/tools/db_init.sh

EXPOSE 3306

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/root/tools/db_init.sh"]