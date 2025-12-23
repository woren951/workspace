#!/usr/bin/env bash
set -e

mkdir -p /run/php-fpm
chown web:web /run/php-fpm

# SSH
echo "Starting sshd..."
mkdir -p /run/sshd
/usr/sbin/sshd

# PHP-FPM
echo "Starting PHP-FPM..."
/opt/remi/php74/root/usr/sbin/php-fpm --daemonize
/opt/remi/php82/root/usr/sbin/php-fpm --daemonize
/opt/remi/php83/root/usr/sbin/php-fpm --daemonize
/usr/sbin/php-fpm --daemonize

# NGINX (foreground!)
echo "Starting nginx..."
nginx -g "daemon off;"
