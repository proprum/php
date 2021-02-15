# php

Need file timezone :

printf '[PHP]\ndate.timezone = "Europe/Paris"\n' > tzfile.ini

and use it to /usr/local/etc/php/conf.d/tzone.ini

Add some apache config file to /etc/apache2/sites-enabled/*.conf, using your own paths to cert files
