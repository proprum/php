FROM php:5.6-apache

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN apt-get update && apt-get install unzip
RUN printf "[Date]\ndate.timezone = 'Europe/Paris'\n" > /usr/local/etc/php/conf.d/tzone.ini  

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && install-php-extensions \
	gd \
	imagick \
	pgsql \
	ldap \
	mcrypt \
	zip \
	calendar \
	intl \
	mysqli
	
RUN	apt-get clean && \
	sed -i $'s#upload_max_filesize.*$#upload_max_filesize = 50M#' /usr/local/etc/php/php.ini-production && \
	sed -i $'s#post_max_size .*$#post_max_size  = 50M#' /usr/local/etc/php/php.ini-production && \
	a2enmod ssl

COPY start.sh /root/start.sh

CMD ["/bin/bash", "/root/start.sh"]

