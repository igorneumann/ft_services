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

# Actualizar
RUN apk --no-cache update && apk --no-cache upgrade

#Instalar grafana
RUN apk add --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache grafana

#configurar datasources y panels
RUN mkdir -p /usr/share/grafana/dashboards/panels
COPY ./*-datasource.yaml /usr/share/grafana/conf/provisioning/datasources/
COPY ./dashboards/panels.yaml /usr/share/grafana/conf/provisioning/dashboards/
COPY ./dashboards/panels/* /usr/share/grafana/conf/provisioning/dashboards/panels/

#expose ports
WORKDIR	/usr/share/grafana

EXPOSE 3000

ENTRYPOINT grafana-server

