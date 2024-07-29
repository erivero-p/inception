
# Especifica la imagen base
FROM  debian:bullseye
#upgrades system
RUN apt update -y && apt upgrade -y 
#installs nginx and ufw
RUN apt -y install nginx
#copies nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf
#664 gives write permission to owner and read permission to group and others
RUN chmod 644 /etc/nginx/nginx.conf
#he visto que aquí la gente copia un .sh (en tools) y le da permisos para luego
#ejecutarlo en CMD, pero no sé qué hace ese .sh :c

#instalamos openssl porque nginx no gestiona bien los certificados por defecto
#generamos un certificado SSL x.509, sin cifrar la clave privada (-nodes), válido por 365 días
#creamos una nueva clave RSA de 2048 bits y guardamos clave y certificado en sus respectvos archivos
RUN apt -y install openssl
RUN mkdir -p $SSL_DIR
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "$SSL_SUBJECT" -keyout $SSL_KEY -out $SSL_CERT

EXPOSE 443

# Comando para ejecutar la aplicación
CMD ["nginx", "daemon off;"]
# CMD ["nginx", "-g", "daemon off;"]
