#!/usr/bin/env bash

# Display PHP error's or not
if [[ "$ERRORS" != "1" ]] ; then
  sed -i -e "s/error_reporting =.*=/error_reporting = E_ALL/g" /etc/php5/fpm/php.ini
  sed -i -e "s/display_errors =.*/display_errors = On/g" /etc/php5/fpm/php.ini
fi

# create folder for nginx pid
mkdir /run/nginx

# Again set the right permissions (needed when mounting from a volume)
chown -Rf www:www /pdnsadmin

# Start services
/usr/sbin/nginx -c /etc/nginx/nginx.conf
/usr/sbin/php-fpm7 -F
