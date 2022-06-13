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
RUN apk --no-cache update && apk --no-cache upgrade
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted --no-cache

ENTRYPOINT /usr/bin/telegraf;