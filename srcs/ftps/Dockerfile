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
RUN apk --no-cache update
RUN apk --no-cache upgrade
RUN apk add --no-cache openssl
RUN apk add --no-cache vsftpd

#instalar certificado
RUN mkdir -p /etc/ssl/private
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

# Create user
RUN adduser --home=/etc/ftps/ftp_admin -D admin && \
    echo "admin:123456" | chpasswd && \
    echo "admin" >> /etc/vsftpd/vsftpd.userlist

#configurar 
RUN touch /var/vsftpd.log && touch /var/vsftpd2.log
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY load.sh /tmp/load.sh
RUN chmod +x /tmp/load.sh

#expose ports
EXPOSE 20 21 30020 30021

ENTRYPOINT vsftpd /etc/vsftpd/vsftpd.conf;