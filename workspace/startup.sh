#!/bin/bash

# Start php-fpm in foreground
# $HOME/.phpenv/versions/7.4.27/etc/init.d/php-fpm start
# $HOME/.phpenv/versions/8.0.16/etc/init.d/php-fpm start
# $HOME/.phpenv/versions/8.1.3/etc/init.d/php-fpm start
$HOME/.asdf/installs/php/7.4.28/sbin/php-fpm
$HOME/.asdf/installs/php/8.0.16/sbin/php-fpm
$HOME/.asdf/installs/php/8.1.3/sbin/php-fpm

# Start nginx in foreground
nginx
