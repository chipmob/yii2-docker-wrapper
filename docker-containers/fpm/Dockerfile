FROM php:7.3-fpm

WORKDIR /var/www

RUN usermod -u 1000 www-data

RUN apt-get update && apt-get -y install \
        gnupg2 \
        wget git ca-certificates libssl-dev libreadline-dev \
        curl \
        unzip \
        nano \
        openssl \
        linkchecker \
        mariadb-client \
        libmcrypt-dev \
        libzip-dev \
        zlib1g-dev \
        libpq-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libicu-dev \
        imagemagick \
        libmagickwand-dev \
        libmemcached-dev \
        libedit-dev \
        libgmp-dev \
        libcurl4-openssl-dev \
        cron \
    --no-install-recommends && \
    rm -r /var/lib/apt/lists/*

RUN curl -sS -o /tmp/icu.tar.gz -L https://github.com/unicode-org/icu/releases/download/release-64-2/icu4c-64_2-src.tgz && \
    tar -zxf /tmp/icu.tar.gz -C /tmp && \
    cd /tmp/icu/source && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    make clean

ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ && \
    docker-php-ext-configure intl --with-icu-dir=/usr/local

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h

RUN docker-php-ext-install soap zip curl bcmath exif gd iconv intl mbstring opcache pdo_mysql pdo_pgsql \
    bz2 xmlrpc readline gmp && \
    pecl install redis-5.2.0 xdebug-2.9.2 imagick-3.4.4 memcached-3.1.5 mcrypt-1.0.1 msgpack-2.1.0 && \
    docker-php-ext-enable redis xdebug imagick

RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer global require "fxp/composer-asset-plugin:^1.2.0"

ENTRYPOINT ["php-fpm"]

RUN rm -rf /tmp/*
