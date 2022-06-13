# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ineumann <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/21 17:07:19 by ineumann          #+#    #+#              #
#    Updated: 2021/02/16 17:58:27 by ineumann         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

# Instalar todo
RUN apk --no-cache update 
RUN apk --no-cache upgrade
RUN apk add --no-cache openrc \
    nginx \
    openssl

# Configurar carpeta
RUN mkdir -p var/run/nginx
RUN chmod 755 -R -c /var/www
WORKDIR /var/www/

#instalar certificado
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#configurar nginx
COPY nginx.conf /etc/nginx/nginx.conf

#expose ports
EXPOSE 22 80 443

#Start nginx
VOLUME [ “/sys/fs/cgroup” ]
RUN openrc
RUN touch /run/openrc/softlevel
RUN rc-status
RUN rc-update add nginx

#Copy some shit
COPY /htdocs/ /var/www/localhost/htdocs/

ENTRYPOINT nginx -g "daemon off;"