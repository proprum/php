# php

Need file timezone :

    printf '[PHP]\ndate.timezone = "Europe/Paris"\n' > tzfile.ini

and use it to `/usr/local/etc/php/conf.d/tzone.ini`

Add some apache config file to `/etc/apache2/sites-enabled/`\*.conf, using your own paths to cert files

```
docker run -d \
  --name php-5.6 \
  -v ~/tzfile.ini:/usr/local/etc/php/conf.d/tzone.ini \
  -v ~/mysite_apache.conf:/etc/apache2/sites-enabled/mysite_apache.conf \
  -p 80:80 \
  -p 443:443 \
  proprum:php
```
