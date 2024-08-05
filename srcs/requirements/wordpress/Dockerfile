# dockerfile for wordpress
#specifies the base image
FROM  debian:bullseye
#upgrades system
RUN apt update -y && apt upgrade -y 
#installs wordpress requirements
RUN apt -y install unzip wget php7.4 php-fpm php-mysql php-curl

#removes the package lists from the image, reducing the image size
#RUN rm -rf /var/lib/apt/lists/*
# idk if I have to do this also in wordorpess, I did it in nginx

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# -p flag creates the directory if it doesn't exist
RUN mkdir -p root/tools/ 

COPY ./tools/wp_init.sh /root/tools/wp_init.sh
# I would like to have a script to download wordpress and another to configure it
# I may call the script to download wordpress from the script to configure it

RUN chmod +x /root/tools/wp_init.sh
#if i didnt call the download.sh script from the init.sh script, I would have to call it here
# RUN /root/tools/wp_download.sh
CMD [ "bash", "/root/tools/wp_init.sh" ]