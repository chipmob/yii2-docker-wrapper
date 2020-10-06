FROM php:7.3-fpm

WORKDIR /var/www

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get -y install gnupg2 && apt-key update

RUN apt-key update && apt-get -y install \
        git \
        ca-certificates \
        curl \
        unzip \
        nano \
        openssl \
        default-mysql-client \
        imagemagick \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libonig-dev \
        libmagickwand-dev \
        libpq-dev \
        libpng-dev \
        libxml2-dev \
        libzip-dev \
        zlib1g-dev \
        libssl-dev \
        libcurl4-openssl-dev \
    --no-install-recommends && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-configure bcmath

RUN docker-php-ext-install soap zip curl bcmath exif gd iconv intl mbstring opcache pdo_mysql pdo_pgsql

RUN pecl install redis-5.3.1 xdebug-2.9.8 imagick-3.4.4 memcached-3.1.5 && \
    docker-php-ext-enable redis xdebug imagick memcached

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "fxp/composer-asset-plugin:^1.2.0"

ENTRYPOINT ["php-fpm"]

RUN rm -rf /tmp/*
