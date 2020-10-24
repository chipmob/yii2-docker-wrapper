#!/usr/bin/env sh
set -e

mkdir -p /var/run/redis
chmod 777 -R /var/run/redis/

mkdir -p /var/log/cron
touch /var/log/cron/php-fpm.log
chmod 777 /var/log/cron/php-fpm.log

chmod 644 /etc/cron.d/php-fpm
crontab /etc/cron.d/php-fpm
cron -f &

exec "$@"
