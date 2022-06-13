# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ineumann <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/01/21 17:07:19 by ineumann          #+#    #+#              #
#    Updated: 2021/02/07 18:49:16 by ineumann         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.12

# Instalar apt-utils y debconf-utils para configuracion, systemctl y Actualizar Debian
RUN apk --no-cache update && apk --no-cache upgrade

#Instalar paquetes adicionales
RUN apk add php7 \
	php7-fpm \
	php7-opcache \
	php7-gd \
	php7-mysqli \
	php7-zlib \
	php7-curl \
	php7-mbstring \
	php7-json \
	php7-session \
	openrc \
	nginx

#Crear carpeta phpmyadmin
RUN mkdir -p /usr/share/webapps/ && \
	mkdir -p /var/www/localhost/htdocs/tmp/ && \
	mkdir -p /run/nginx/ && \
	cd /usr/share/webapps && \
	wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz && \
	tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz && \
	rm phpMyAdmin-5.0.2-all-languages.tar.gz && \
	chmod -R 755 /usr/share/webapps/ && \
	cp -R /usr/share/webapps/phpMyAdmin-5.0.2-all-languages/* /var/www/localhost/htdocs/

#configurar nginx
COPY nginx.conf /etc/nginx/nginx.conf

# usuario NGINX
RUN adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chmod 755 -R -c /var/www && \
	chmod 777 /var/www/localhost/htdocs/tmp/

#Configurar phpmyadmin
COPY config.inc.php /var/www/localhost/htdocs/config.inc.php

#Start nginx
VOLUME [ “/sys/fs/cgroup” ]
RUN openrc
RUN touch /run/openrc/softlevel
RUN rc-status
RUN rc-update add nginx
RUN rc-update add php-fpm7

#expose ports
EXPOSE 5000

ENTRYPOINT php-fpm7 -R; nginx -g "daemon off;"