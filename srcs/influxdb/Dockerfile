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

# Instalar 
RUN apk --no-cache update && apk --no-cache upgrade && \
    apk add influxdb

# Copiar configuracion 
RUN mkdir -p /etc/influxdb
COPY influxdb.conf /etc/influxdb/influxdb.conf

#expose ports
EXPOSE 8086

ENTRYPOINT influxd