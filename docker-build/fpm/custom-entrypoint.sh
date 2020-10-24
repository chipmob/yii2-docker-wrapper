#!/usr/bin/env sh
set -e

mkdir -p /var/log/cron
touch /var/log/cron/php-fpm.log
chmod 0777 /var/log/cron/php-fpm.log

chmod 0644 /etc/cron.d/php-fpm
crontab /etc/cron.d/php-fpm
cron -f

exec docker-php-entrypoint "$@"
