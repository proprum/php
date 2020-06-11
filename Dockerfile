FROM php:5.6-apache

ENV 	OBJECT  "/CN=example.org"

ADD https://raw.githubusercontent.com/mlocati/docker-php-extension-installer/master/install-php-extensions /usr/local/bin/

RUN apt-get update && apt-get install unzip

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
	printf '[PHP]\ndate.timezone = "Europe/Paris"\n' > /usr/local/etc/php/conf.d/tzone.ini && \
	rm -rf /var/www/html && mkdir /var/www/htdocs && \
	sed -i "s#DocumentRoot /var/www/html#DocumentRoot /var/www/htdocs#g" /etc/apache2/sites-available/default-ssl.conf && \
	a2enmod ssl && a2ensite default-ssl.conf

CMD  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key \ 
	-out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj $OBJECT && \
	apache2-foreground

EXPOSE 80
EXPOSE 443
