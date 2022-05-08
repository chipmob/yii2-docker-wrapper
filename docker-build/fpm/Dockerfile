FROM php:7.4-fpm

# https://github.com/devilbox/docker-php-fpm-7.4

RUN curl -sS -o /tmp/icu.tar.gz -L https://github.com/unicode-org/icu/releases/download/release-69-1/icu4c-69_1-src.tgz && \
    tar -zxf /tmp/icu.tar.gz -C /tmp && \
    cd /tmp/icu/source && \
    ./configure --prefix=/usr/local && \
    make && make install && make clean && \
    rm -rf /tmp/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libbz2-dev \
        libzip-dev \
        libmcrypt-dev \
        # libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        # libmagickwand-dev \
        unzip git cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-configure intl && \
    docker-php-ext-install bcmath bz2 exif gd intl opcache pdo_mysql zip

COPY docker-php-ext-get /usr/local/bin/

RUN docker-php-source extract && \
    # docker-php-ext-get imagick 3.7.0 && \
    # docker-php-ext-install imagick && \
    docker-php-ext-get igbinary 3.2.7 &&\
    docker-php-ext-install igbinary &&\
    docker-php-ext-get redis 5.3.7 && \
    docker-php-ext-configure redis --enable-redis-igbinary && \
    docker-php-ext-install redis && \
    # docker-php-ext-get xdebug 2.9.8 && \
    # docker-php-ext-install xdebug && \
    rm -rf /usr/src/php/

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && composer clear-cache

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
