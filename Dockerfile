FROM php:5.6-apache

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && install-php-extensions \
	gd \
	pgsql \
	imagick \
	ldap \
	mcrypt \
	zip \
	calendar \
	intl 
	
RUN	apt-get clean && \
	printf '[PHP]\ndate.timezone = "Europe/Paris"\n' > /usr/local/etc/php/conf.d/tzone.ini

ENV 	OBJECT  "/CN=example.org"

RUN 	a2enmod ssl && a2ensite default-ssl.conf

CMD  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key \ 
	-out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj $OBJECT && \
	apache2-foreground

EXPOSE 80
EXPOSE 443
