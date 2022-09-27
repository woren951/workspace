#!/bin/bash

# installing php-5.6.40 if not installed
if [ ! -d "${1}/5.6.40" ]; then
    asdf php update php-build

    PHP_BUILD_CONFIGURE_OPTS="--with-gettext" asdf install php 5.6.40

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9056/' ${1}/5.6.40/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/5.6.40/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/5.6.40/etc/php-fpm.d/www.conf

    asdf global php 5.6.40 && \
        ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install libsodium imagick redis && \
        echo 'extension=sodium.so' > ${1}/5.6.40/etc/conf.d/sodium.ini && \
        echo 'extension=imagick.so' > ${1}/5.6.40/etc/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/5.6.40/etc/conf.d/redis.ini
fi

# installing php-7.1.33 if not installed
if [ ! -d "${1}/7.1.33" ]; then
    asdf php update php-build

    PHP_BUILD_CONFIGURE_OPTS="--with-gettext" asdf install php 7.1.33

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9071/' ${1}/7.1.33/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/7.1.33/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/7.1.33/etc/php-fpm.d/www.conf

    asdf global php 7.1.33 && \
        ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install libsodium imagick redis && \
        echo 'extension=sodium.so' > ${1}/7.1.33/etc/conf.d/sodium.ini && \
        echo 'extension=imagick.so' > ${1}/7.1.33/etc/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/7.1.33/etc/conf.d/redis.ini
fi

# installing php-7.4.28 if not installed
if [ ! -d "${1}/7.4.28" ]; then
    asdf php update php-build

    PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium" asdf install php 7.4.28

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9074/' ${1}/7.4.28/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/7.4.28/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/7.4.28/etc/php-fpm.d/www.conf

    asdf global php 7.4.28 && \
        ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis && \
        echo 'extension=imagick.so' > ${1}/7.4.28/etc/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/7.4.28/etc/conf.d/redis.ini
fi

# installing php-8.0.23 if not installed
if [ ! -d "${1}/8.0.23" ]; then
    asdf php update php-build

    PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium" asdf install php 8.0.23

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9080/' ${1}/8.0.23/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/8.0.23/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/8.0.23/etc/php-fpm.d/www.conf

    asdf global php 8.0.23 && \
        ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis && \
        echo 'extension=imagick.so' > ${1}/8.0.23/etc/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/8.0.23/etc/conf.d/redis.ini
fi

# installing php-8.1.10 if not installed
if [ ! -d "${1}/8.1.10" ]; then
    asdf php update php-build

    PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium" asdf install php 8.1.10

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9081/' ${1}/8.1.10/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/8.1.10/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/8.1.10/etc/php-fpm.d/www.conf

    asdf global php 8.1.10 && \
        ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis && \
        echo 'extension=imagick.so' > ${1}/8.1.10/etc/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/8.1.10/etc/conf.d/redis.ini
fi
