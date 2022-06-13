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
RUN apk add --no-cache openrc \
	php7 \
	php7-fpm \
	php7-opcache \
	php7-gd \
	php7-mysqli \
	php7-zlib \
	php7-curl \
	php7-mbstring \
	php7-phar \
	php7-json \
	php7-session \
	openssl \
	make \
	go \
	nginx

#Instalar servicios extra
RUN apk add --no-cache wget \
	curl \
	openrc

#Instalar WP-cli
RUN cd /tmp/ && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x /tmp/wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# Crear carpeta
RUN mkdir -p /usr/share/webapps/ && \
	mkdir -p /var/www/temp/htdocs && \
	mkdir -p /run/nginx/

#configurar nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Bajar Wordpress
RUN cd /usr/share/webapps/ && \
	wget http://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz

# Mover Wordpress
RUN mv /usr/share/webapps/wordpress/* /var/www/temp/htdocs/

# usuario NGINX
RUN adduser -D -g 'www' www && \
	chown -R www:www /var/lib/nginx && \
	chmod 777 -R -c /var/www

# Copy some shit
COPY wp-config.php /var/www/temp/htdocs/wp-config.php
COPY install.sh /var/www/temp/htdocs/install.sh
RUN chmod +x /var/www/temp/htdocs/install.sh

#expose ports
EXPOSE 5050

#Start nginx
VOLUME [ “/sys/fs/cgroup” ]
RUN openrc
RUN touch /run/openrc/softlevel
RUN rc-status
RUN rc-update add nginx
RUN rc-update add php-fpm7

ENTRYPOINT /var/www/temp/htdocs/install.sh; php-fpm7 -R; nginx -g "daemon off;"