#!/bin/bash

# # installing php-7.1.33 if not installed
# if [ ! -d "${1}/7.1.33" ]; then
#     asdf install php 7.1.33

#     cp ${1}/7.1.33/php-fpm.conf.default ${1}/7.1.33/php-fpm.conf && \
#         cp ${1}/7.1.33/php-fpm.d/www.conf.default ${1}/7.1.33/php-fpm.d/www.conf && \
#         sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9071/' ${1}/7.1.33/php-fpm.d/www.conf && \
#         sed -i 's/user = www-data/user = web/' ${1}/7.1.33/php-fpm.d/www.conf && \
#         sed -i 's/group = www-data/group = web/' ${1}/7.1.33/php-fpm.d/www.conf

#     cp -r php/php7.1.ini ${1}/7.1.33/conf.d/php.ini

#     asdf global php 7.1.33 && \
#         $ASDF_DATA_DIR/shims/pecl install libsodium imagick && \
#         echo 'extension=sodium.so' > ${1}/7.1.33/conf.d/sodium.ini && \
#         echo 'extension=imagick.so' > ${1}/7.1.33/conf.d/imagick.ini
# fi

# installing php-7.4.28 if not installed
if [ ! -d "${1}/7.4.28" ]; then
    asdf install php 7.4.28

    cp ${1}/7.4.28/php-fpm.conf.default ${1}/7.4.28/php-fpm.conf && \
        cp ${1}/7.4.28/php-fpm.d/www.conf.default ${1}/7.4.28/php-fpm.d/www.conf && \
        sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9074/' ${1}/7.4.28/php-fpm.d/www.conf && \
        sed -i 's/user = www-data/user = web/' ${1}/7.4.28/php-fpm.d/www.conf && \
        sed -i 's/group = www-data/group = web/' ${1}/7.4.28/php-fpm.d/www.conf

    cp ${ASDF_DATA_DIR}/php-ini/php7.4.ini ${1}/7.4.28/conf.d/php.ini

    asdf global php 7.4.28 && \
        $ASDF_DATA_DIR/shims/pecl channel-update pecl.php.net && \
        printf "\n" | $ASDF_DATA_DIR/shims/pecl install libsodium imagick redis xdebug && \
        echo 'extension=sodium.so' > ${1}/7.4.28/conf.d/sodium.ini && \
        echo 'extension=imagick.so' > ${1}/7.4.28/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/7.4.28/conf.d/redis.ini && \
        echo 'zend_extension=xdebug' > ${1}/7.4.28/conf.d/xdebug.ini

    echo '' | tee -a ${1}/7.4.28/conf.d/xdebug.ini && \
        echo 'xdebug.mode=develop,coverage,debug,profile' | tee -a ${1}/7.4.28/conf.d/xdebug.ini && \
        echo 'xdebug.start_with_request=yes' | tee -a ${1}/7.4.28/conf.d/xdebug.ini && \
        echo 'xdebug.log_level=0' | tee -a ${1}/7.4.28/conf.d/xdebug.ini && \
        echo '' | tee -a ${1}/7.4.28/conf.d/xdebug.ini
fi

# installing php-8.0.16 if not installed
if [ ! -d "${1}/8.0.16" ]; then
    asdf install php 8.0.16

    cp ${1}/8.0.16/php-fpm.conf.default ${1}/8.0.16/php-fpm.conf && \
        cp ${1}/8.0.16/php-fpm.d/www.conf.default ${1}/8.0.16/php-fpm.d/www.conf && \
        sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9080/' ${1}/8.0.16/php-fpm.d/www.conf && \
        sed -i 's/user = www-data/user = web/' ${1}/8.0.16/php-fpm.d/www.conf && \
        sed -i 's/group = www-data/group = web/' ${1}/8.0.16/php-fpm.d/www.conf

    cp ${ASDF_DATA_DIR}/php-ini/php8.0.ini ${1}/8.0.16/conf.d/php.ini

    asdf global php 8.0.16 && \
        $ASDF_DATA_DIR/shims/pecl channel-update pecl.php.net && \
        printf "\n" | $ASDF_DATA_DIR/shims/pecl install imagick redis xdebug && \
        echo 'extension=imagick.so' > ${1}/8.0.16/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/8.0.16/conf.d/redis.ini && \
        echo 'zend_extension=xdebug' > ${1}/8.0.16/conf.d/xdebug.ini

    echo '' | tee -a ${1}/8.0.16/conf.d/xdebug.ini && \
        echo 'xdebug.mode=develop,coverage,debug,profile' | tee -a ${1}/8.0.16/conf.d/xdebug.ini && \
        echo 'xdebug.start_with_request=yes' | tee -a ${1}/8.0.16/conf.d/xdebug.ini && \
        echo 'xdebug.log_level=0' | tee -a ${1}/8.0.16/conf.d/xdebug.ini && \
        echo '' | tee -a ${1}/8.0.16/conf.d/xdebug.ini
fi

# installing php-8.1.3 if not installed
if [ ! -d "${1}/8.1.3" ]; then
    PHP_CONFIGURE_OPTIONS="--with-openssl --with-curl --with-zlib --with-readline --with-gettext --with-sodium" asdf install php 8.1.3

    cp ${1}/8.1.3/php-fpm.conf.default ${1}/8.1.3/php-fpm.conf && \
        cp ${1}/8.1.3/php-fpm.d/www.conf.default ${1}/8.1.3/php-fpm.d/www.conf && \
        sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9081/' ${1}/8.1.3/php-fpm.d/www.conf && \
        sed -i 's/user = www-data/user = web/' ${1}/8.1.3/php-fpm.d/www.conf && \
        sed -i 's/group = www-data/group = web/' ${1}/8.1.3/php-fpm.d/www.conf

    cp ${ASDF_DATA_DIR}/php-ini/php8.1.ini ${1}/8.1.3/conf.d/php.ini

    asdf global php 8.1.3 && \
        $ASDF_DATA_DIR/shims/pecl channel-update pecl.php.net && \
        printf "\n" | $ASDF_DATA_DIR/shims/pecl install imagick redis xdebug && \
        echo 'extension=imagick.so' > ${1}/8.1.3/conf.d/imagick.ini && \
        echo 'extension=redis.so' > ${1}/8.1.3/conf.d/redis.ini && \
        echo 'zend_extension=xdebug' > ${1}/8.1.3/conf.d/xdebug.ini

    echo '' | tee -a ${1}/8.1.3/conf.d/xdebug.ini && \
        echo 'xdebug.mode=develop,coverage,debug,profile' | tee -a ${1}/8.1.3/conf.d/xdebug.ini && \
        echo 'xdebug.start_with_request=yes' | tee -a ${1}/8.1.3/conf.d/xdebug.ini && \
        echo 'xdebug.log_level=0' | tee -a ${1}/8.1.3/conf.d/xdebug.ini && \
        echo '' | tee -a ${1}/8.1.3/conf.d/xdebug.ini
fi
