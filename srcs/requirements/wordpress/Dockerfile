FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install php-fpm php-mysql wget unzip tini -y

COPY ./tools/wp.sh /tmp/wp.sh

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "/tmp/wp.sh"]