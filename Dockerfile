FROM alpine:edge

MAINTAINER Chuyen Pham <pkchuyen@gmail.com>

ENV composer_hash 669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410

# Add repository source for php7
# RUN echo -e "http://dl-cdn.alpinelinux.org/alpine/edge/main\nhttp://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

# install php7
RUN echo "http://dl-4.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories \
 && apk upgrade -q -U -a \
 && apk --no-cache --update add \
# install APP
        bash \
        git \
        nginx \
# install PHP
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-gd \
        php7-zlib \        
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-posix \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
# install composer
    # && ln -s /usr/bin/php7 /usr/bin/php \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '${composer_hash}') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
# Setup pdnsadmin source code
    && git clone https://github.com/pdnsadmin/pdnsadmin.git /pdnsadmin \
    && cd /pdnsadmin && mv /pdnsadmin/.env.example /pdnsadmin/.env \
    && composer update && php artisan key:generate \
    && mkdir /pdnsadmin/public/uploads \
    && chown -R nobody:nobody /pdnsadmin \
# # clean up to keep docker images in minimum size
    && cd /pdnsadmin && rm -rf .git .gitignore .gitattributes composer.lock && rm -rf /root/.composer \
    && rm -rf /var/cache/apk/*


############### CONFIG ###############
# Add Nginx config
COPY nginx/pdnsadmin.conf /etc/nginx/conf.d/default.conf

# Add php-fpm config
COPY php7/php.ini /etc/php7/conf.d/50-setting.ini
COPY php7/php-fpm.conf /etc/php7/php-fpm.conf

# Starting scripts
ADD script/entrypoint.sh /
RUN chmod +x /entrypoint.sh

############### EXPOSE PORT ###############
# Expose the ports for nginx
EXPOSE 80/tcp

ENTRYPOINT ["/entrypoint.sh"]
