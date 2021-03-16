# php

Override default (Europe/Paris) timezone : `-v ~/tzone.ini:/usr/local/etc/php/conf.d/tzone.ini`

## HTTPS ##

Drop your own certificate + key on certs : `-v ~/certs:/certs` No need to configure, automatically integrated

If you don't do provide your certs, it will auto-generate one self-signed, using `SERVERNAME` provided CN



## RUN ##

```
docker run -d \
  --name php \
  -v ~/tzfile.ini:/usr/local/etc/php/conf.d/tzone.ini \
  -v ~/certs:/certs \
  -e SERVERNAME=example.org
  -p 80:80 \
  -p 443:443 \
  proprum/php:$VERS
```
