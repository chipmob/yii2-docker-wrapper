#!/usr/bin/env sh
set -e

mkdir -p /var/run/redis
chown -R 999:999 /var/run/redis
chmod 1777 /var/run/redis

mkdir -p /var/run/mysqld
chown -R 999:999 /var/run/mysqld
chmod 1777 /var/run/mysqld

mkdir -p /var/log/cron
touch /var/log/cron/php-fpm.log
chmod 777 /var/log/cron/php-fpm.log

chmod 644 /etc/cron.d/php-fpm
crontab /etc/cron.d/php-fpm
cron -f &

if [ "${1#-}" != "$1" ]; then
  set -- php-fpm "$@"
fi

exec "$@"
