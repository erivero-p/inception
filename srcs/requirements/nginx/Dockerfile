
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
EXPOSE 80

# Comando para ejecutar la aplicación
CMD ["sleep", "10000"]
# provisional obviamente
# me ha dicho andrés que cuando hay más de un CMD sólo se ejecuta el último

# es posible que ssl no fufe en el nginx de debian, si es así, 
# habría que instalarlo con apt install nginx-extras, openssl o mkcert
# lo puedo hacer aquí, o meter en tools un .sh que lo haga