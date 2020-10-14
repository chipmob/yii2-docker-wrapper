#!/bin/sh
set -e

cron -f & docker-php-entrypoint php-fpm

exec "$@"
