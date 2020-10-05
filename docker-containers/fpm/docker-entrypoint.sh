#!/bin/sh
set -e

cron -f &
php-fpm

exec "$@"