FROM debian:bullseye

RUN apt update -y && apt upgrade -y
RUN apt -y install unzip wget php php7.4 php-fpm php-mysql

RUN mkdir -p /root/tools

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY ./tools/download_wp.sh /root/tools/download_wp.sh
COPY ./tools/use_wp.sh /root/tools/use_wp.sh
RUN chmod +x /root/tools/download_wp.sh
RUN chmod +x /root/tools/use_wp.sh

RUN /root/tools/download_wp.sh

CMD ["/root/tools/use_wp.sh"]