#!/usr/bin/env sh
set -e

cron -f & docker-php-entrypoint php-fpm

exec "$@"
