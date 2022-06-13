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

# Instalar y Actualizar
RUN apk --no-cache update && apk --no-cache upgrade && \
    apk add mariadb \
    mariadb-client

COPY mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

#Create folder
RUN mkdir -p /run/mysqld && \
    chown -R root:root /run/mysqld

#Copiar mysql y setup
COPY *.sql /etc/
COPY setup.sh /etc/setup.sh
RUN chmod +x /etc/setup.sh

#expose ports
EXPOSE 3306

ENTRYPOINT /etc/setup.sh; mysqld --user=root;