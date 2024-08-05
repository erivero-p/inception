#!/bin/bash

# Substitute environment variables in nginx.conf
sed -i "s#\${DOMAIN}#$DOMAIN#g" /etc/nginx/nginx.conf
sed -i "s#\${SSL_CERT}#$SSL_CERT#g" /etc/nginx/nginx.conf
sed -i "s#\${SSL_KEY}#$SSL_KEY#g" /etc/nginx/nginx.conf

# Create directory for SSL certificates if it doesn't exist
# mkdir -p $SSL_DIR
#export $(grep -v '^#' /root/.env | xargs)

mkdir -p /etc/nginx/ssl

# Generate SSL certificate
echo "Generating SSL certificate..."
echo ssl key: $SSL_KEY
echo ssl cert: $SSL_CERT
sleep 10
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Malaga/L=Malaga/O=42 Malaga/OU=erivero-/CN=erivero-" -keyout "$SSL_KEY" -out "$SSL_CERT"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Malaga/L=Malaga/O=42 Malaga/OU=erivero-/CN=erivero-" -keyout "/etc/nginx/ssl/erivero-.key" -out "/etc/nginx/ssl/erivero-.crt"


    # # echo "${BLUE}Install Dependencies${NC}"
    # apt install -y wget curl libnss3-tools
    # # echo "${GREEN}Dependencies Installed${NC}"

    # # echo "${BLUE}Downloading and Installing MKCERT${NC}"
    # curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64"
    # chmod +x mkcert-v*-linux-amd64
    # cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert
    # # echo "${GREEN}MKCERT Installed${NC}"

    # # echo "${BLUE}Creatign SSL Certs${NC}"
    # mkdir /etc/nginx/ssl
    # cd /etc/nginx/ssl/
    # mkcert erivero-
    # mv erivero--key.pem erivero-.key
    # mv erivero-.pem erivero-.crt
    # # echo "${GREEN}SSL Certs Created${NC}"
    # chmod 777 /etc/nginx/ssl/*




# echo "SSL certificate generated"
# Start Nginx
# nginx -g "daemon off;"