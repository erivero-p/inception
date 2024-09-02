FROM debian:bullseye

#upgrades system and installs the necessary packages
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install nginx openssl tini -y

# copies config and init files givin them the necessary permissions
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/nginx.sh /tmp/nginx.sh
RUN chmod 644 /etc/nginx/nginx.conf 
RUN chmod +x /tmp/nginx.sh

#exposes the 443 port
EXPOSE 443

#sets the entrypoint with tini to init the container
ENTRYPOINT ["/usr/bin/tini", "--"]

#creates the ssl certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Malaga/L=Malaga/O=42 Malaga/OU=erivero-/CN=erivero-" -keyout "/etc/nginx/ssl/erivero-.key" -out "/etc/nginx/ssl/erivero-.crt"

CMD ["nginx", "-g", "daemon off;"]
