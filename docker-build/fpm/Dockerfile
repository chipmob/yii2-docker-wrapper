FROM php:7.4-fpm

# https://github.com/devilbox/docker-php-fpm-7.4

RUN apt-get update && apt-get -y install \
        git unzip nano cron \
        libzip-dev \
        libmcrypt-dev \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libmagickwand-dev \
        libxslt-dev \
    --no-install-recommends && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install bcmath exif gd intl opcache pdo_mysql zip xsl

COPY docker-php-ext-get /usr/local/bin/

RUN docker-php-source extract && \
    docker-php-ext-get imagick 3.4.4 && \
    docker-php-ext-install imagick && \
    docker-php-ext-get igbinary 3.1.6 &&\
    docker-php-ext-install igbinary &&\
    docker-php-ext-get redis 5.3.2 && \
    docker-php-ext-configure redis --enable-redis-igbinary && \
    docker-php-ext-install redis && \
    docker-php-ext-get xdebug 2.9.8 && \
    docker-php-ext-install xdebug

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.17 && \
    composer global require "fxp/composer-asset-plugin:^1.4.0"

RUN rm -rf /tmp/*

WORKDIR /var/www

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
