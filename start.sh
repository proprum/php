#!/bin/bash

setted=$(grep SSLCertificateFile /etc/apache2/sites-enabled/default-ssl.conf | grep snakeoil)

if [ ! -z "$setted" ] ; then
  mkdir -p /certs
  
  # Check certificate presence
  certFile=$(grep -r 'BEGIN CERTIFICATE' /certs | awk -F ':' '{print $1}')
  if [ -z "$certFile" ] ; then
  
    # Check if certificate has private key
    isAll=$(grep 'BEGIN PRIVATE KEY' $certFile)
    if [ -z "$isAll" ] ; then
    
      # Check if private key is there if not in certificate file
      keyFile=$(grep -r 'BEGIN CERTIFICATE' /certs | awk -F ':' '{print $1}')
      if [ -z "$keyFile" ] ; then
        echo "Certificate found but no Private Key provided"
        exit 1
      fi
    fi # Fi isAll
    
  else # no certFile
    # Check if private key is there without certFile
    keyFile=$(grep -r 'BEGIN CERTIFICATE' /certs | awk -F ':' '{print $1}')
    if [ ! -z "$keyFile" ] ; then
      echo "Private Key found but no Certificate provided"
      exit 1
    fi
    
    openssl req -new -x509 -sha256 -newkey rsa:3072 -nodes -keyout /certs/priv.key -days 365 -out /certs/cert.pem -subj "/CN=$SERVERNAME"
    if [[ $? == 0 ]] ; then
      cat /certs/priv.key >> /certs/cert.pem
      certFile='/certs/cert.pem'
      isAll="TRUE"
    else
      echo "Unable to generate certificates" && exit 1
    fi
      
  fi
     
  # Using privateKey in apache config
  sed -i "s#\(\s*SSLCertificateFile\).*#\1 $certFile#" /etc/apache2/sites-enabled/default-ssl.conf 
  if [ -z "$isAll" ] && [ ! -z "$keyFile" ] ; then
    sed -i "s#\(\s*SSLCertificateKeyFile\).*#\1 $keyFile#" /etc/apache2/sites-enabled/default-ssl.conf 
  else 
    sed -i "s#\(\s*SSLCertificateKeyFile\).*#\#\0#" /etc/apache2/sites-enabled/default-ssl.conf 
  fi
  
  if [ ! -z "$ROOTDIR" ] ; then 
    sed "s#\(\s*DocumentRoot\s\).*#\1$ROOTDIR#" /etc/apache2/sites-enabled/*.conf
  fi 
  
fi

apache2-foreground
    
