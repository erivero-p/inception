# Especifica la imagen base
FROM  debian:bullseye
#upgrades system
RUN apt update -y && apt upgrade -y 
#installs nginx and ufw
RUN apt -y install nginx ufw
RUN ufw allow https
#copies nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY ./tools/init.sh /root/tools/init.sh
COPY ../tools/erivero-.42.fr.crt /etc/nginx/ssl/erivero-.42.fr.crt
COPY ../tools/erivero-.42.fr.key /etc/nginx/ssl/erivero-.42.fr.key

RUN chmpd 600 /etc/nginx/ssl/erivero-.42.fr.crt /etc/nginx/ssl/erivero-.42.fr.key

# COPY ./conf/index.html /var/www/index.html

#664 gives write permission to owner and read permission to group and others
RUN chmod 644 /etc/nginx/nginx.conf 
RUN chmod +x /root/tools/init.sh


#instalamos openssl porque nginx no gestiona bien los certificados por defecto
#generamos un certificado SSL x.509, sin cifrar la clave privada (-nodes), válido por 365 días
#creamos una nueva clave RSA de 2048 bits y guardamos clave y certificado en sus respectvos archivos
RUN apt -y install openssl
# RUN mkdir -p /etc/nginx/ssl

EXPOSE 443

# Comando para ejecutar la aplicación
# CMD ["./root/tools/init.sh"]

# RUN "./root/tools/init.sh"

CMD ["nginx", "-g", "daemon off;"]
