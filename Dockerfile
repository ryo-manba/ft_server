# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rmatsuka <rmatsuka@student.42tokyo.jp>     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/05/11 21:03:11 by rmatsuka          #+#    #+#              #
#    Updated: 2021/05/17 21:40:15 by rmatsuka         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

ENV AUTOINDEX="on"

# Debug
RUN	set -ex

# Install Items
RUN	apt-get update; \
	apt-get -y --no-install-recommends install \
	nginx \
	vim \
	openssl \
	php \
	php-fpm \
	mariadb-server \
	mariadb-client \
	php-cgi \
	php-common \
	php-fpm \
	php-pear \
	php-mbstring \
	php-zip \
	php-net-socket \
	php-gd \
	php-xml-util \
	php-gettext \
	php-mysql \
	php-bcmath \
	wget; \
	rm -rf /var/lib/apt/lists/*

COPY ./srcs/wp-config.php ./
COPY ./srcs/config.inc.php ./
COPY ./srcs/start.sh ./
COPY ./srcs/default /etc/nginx/sites-available/

ENV WP_URL=http://wordpress.org//latest.tar.gz
ENV	WP_PATH=/var/www/html/wordpress
ENV	WP_TAR=latest.tar.gz

ENV	PHPMYADMIN_URL=https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
ENV	PHPMYADMIN_PATH=/var/www/html/phpmyadmin
ENV	PHPMYADMIN_TAR=phpmyadmin.tar.gz

# Setting SSL
RUN	mkdir /etc/nginx/ssl; \
	openssl req -x509 -sha256 -newkey rsa:2048 -days 365 -nodes \
	-out /etc/nginx/ssl/nginx.crt \
	-keyout /etc/nginx/ssl/nginx.key \
	-subj "/C=JP/ST=Tokyo/L=Minato/O=42Tokyo/OU=Student/CN=localhost"

# Install WordPress
RUN	wget --no-check-certificate $WP_URL; \
	tar xvf $WP_TAR; \
	rm $WP_TAR; \
	mv wordpress $WP_PATH; \
	mv wp-config.php $WP_PATH

# Install PhpMyAdmin
RUN wget -O $PHPMYADMIN_TAR --no-check-certificate $PHPMYADMIN_URL; \
	tar xvf $PHPMYADMIN_TAR; \
	mv phpMyAdmin-5.0.2-all-languages $PHPMYADMIN_PATH; \
	rm -rf $PHPMYADMIN_TAR; \
	mv config.inc.php $PHPMYADMIN_PATH/config.inc.php

CMD ./start.sh

EXPOSE 80
EXPOSE 443
