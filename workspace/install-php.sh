#!/bin/bash

# Load extension plugin
source "${2}/plugins/php/.php-build/share/php-build/extension/extension.sh"

# installing php-5.6.40 if not installed
# if [ ! -d "${1}/5.6.40" ]; then
#     asdf php update php-build

#     PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/lib/openssl-1.1/pkgconfig" \
#         PHP_BUILD_CONFIGURE_OPTS="--with-gettext" \
#         asdf install php 5.6.40

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9056/' ${1}/5.6.40/etc/php-fpm.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/5.6.40/etc/php-fpm.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/5.6.40/etc/php-fpm.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/5.6.40/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/5.6.40/etc/php.ini

#     asdf global php 5.6.40 && \
#         ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis-2.2.8 && \
#         echo 'extension=imagick.so' > ${1}/5.6.40/etc/conf.d/imagick.ini && \
#         echo 'extension=redis.so' > ${1}/5.6.40/etc/conf.d/redis.ini
# fi

# installing php-7.1.33 if not installed
# if [ ! -d "${1}/7.1.33" ]; then
#     asdf php update php-build

#     PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/lib/openssl-1.1/pkgconfig" \
#         PHP_BUILD_CONFIGURE_OPTS="--with-gettext" \
#         asdf install php 7.1.33

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9071/' ${1}/7.1.33/etc/php-fpm.d/www.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/7.1.33/etc/php-fpm.d/www.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/7.1.33/etc/php-fpm.d/www.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/7.1.33/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/7.1.33/etc/php.ini

#     asdf global php 7.1.33 && \
#         ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install libsodium imagick redis && \
#         echo 'extension=sodium.so' > ${1}/7.1.33/etc/conf.d/sodium.ini && \
#         echo 'extension=imagick.so' > ${1}/7.1.33/etc/conf.d/imagick.ini && \
#         echo 'extension=redis.so' > ${1}/7.1.33/etc/conf.d/redis.ini
# fi

# installing php-7.4.33 if not installed
# if [ ! -d "${1}/7.4.33" ]; then
#     asdf php update php-build

#     PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/lib/openssl-1.1/pkgconfig" \
#         PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium" \
#         asdf install php 7.4.33

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9074/' ${1}/7.4.33/etc/php-fpm.d/www.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/7.4.33/etc/php-fpm.d/www.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/7.4.33/etc/php-fpm.d/www.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/7.4.33/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/7.4.33/etc/php.ini

#     asdf global php 7.4.33 && \
#         ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis && \
#         echo 'extension=imagick.so' > ${1}/7.4.33/etc/conf.d/imagick.ini && \
#         echo 'extension=redis.so' > ${1}/7.4.33/etc/conf.d/redis.ini
# fi

# installing php-8.0.26 if not installed
# if [ ! -d "${1}/8.0.26" ]; then
#     asdf php update php-build

#     PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/lib/openssl-1.1/pkgconfig" \
#         PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium" \
#         asdf install php 8.0.26

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9080/' ${1}/8.0.26/etc/php-fpm.d/www.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/8.0.26/etc/php-fpm.d/www.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/8.0.26/etc/php-fpm.d/www.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/8.0.26/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/8.0.26/etc/php.ini

#     asdf global php 8.0.26 && \
#         ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install imagick redis && \
#         echo 'extension=imagick.so' > ${1}/8.0.26/etc/conf.d/imagick.ini && \
#         echo 'extension=redis.so' > ${1}/8.0.26/etc/conf.d/redis.ini
# fi

# # installing php-8.1.29 if not installed
# if [ ! -d "${1}/8.1.29" ]; then
#     asdf php update php-build

#     PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/lib/gcc12/pkgconfig" \
#         PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium --with-pgsql --with-pdo-pgsql" &&
#         asdf install php 8.1.29

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9081/' ${1}/8.1.29/etc/php-fpm.d/www.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/8.1.29/etc/php-fpm.d/www.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/8.1.29/etc/php-fpm.d/www.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/8.1.29/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/8.1.29/etc/php.ini

#     asdf global php 8.1.29 && \
#         ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install redis excimer && \
#         echo 'extension=redis.so' > ${1}/8.1.29/etc/conf.d/redis.ini && \
#         echo 'extension=excimer.so' > ${1}/8.1.29/etc/conf.d/excimer.ini
# fi

# # installing php-8.2.21 if not installed
# if [ ! -d "${1}/8.2.21" ]; then
#     asdf php update php-build

#     PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-sodium --with-pgsql --with-pdo-pgsql --with-pear" && \
#         asdf install php 8.2.21

#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9082/' ${1}/8.2.21/etc/php-fpm.d/www.conf && \
#     sed -i 's/user = nobody/user = web/' ${1}/8.2.21/etc/php-fpm.d/www.conf && \
#     sed -i 's/group = nobody/group = web/' ${1}/8.2.21/etc/php-fpm.d/www.conf

#     sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/8.2.21/etc/php.ini && \
#     sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/8.2.21/etc/php.ini

#     asdf global php 8.2.21 && \
#         install_extension "excimer" "1.2.1" && \
#         install_extension "redis" "6.0.2"
#         # ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
#         # printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install redis excimer && \
#         # echo 'extension=redis.so' > ${1}/8.2.21/etc/conf.d/redis.ini && \
#         # echo 'extension=excimer.so' > ${1}/8.2.21/etc/conf.d/excimer.ini
# fi

# installing php-8.3.9 if not installed
if [ ! -d "${1}/8.3.9" ]; then
    asdf php update php-build

    # PHP_BUILD_CONFIGURE_OPTS="--with-gettext --with-pgsql --with-pdo-pgsql" && \
    #     PHP_BUILD_INSTALL_EXTENSION="redis=6.0.2 excimer=1.2.1" && \
        asdf install php 8.3.9

    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9083/' ${1}/8.3.9/etc/php-fpm.d/www.conf && \
    sed -i 's/user = nobody/user = web/' ${1}/8.3.9/etc/php-fpm.d/www.conf && \
    sed -i 's/group = nobody/group = web/' ${1}/8.3.9/etc/php-fpm.d/www.conf

    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' ${1}/8.3.9/etc/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 256M/' ${1}/8.3.9/etc/php.ini

    asdf global php 8.3.9
        # install_extension "excimer" "1.2.1" && \
        # install_extension "redis" "6.0.2"
        # ${ASDF_DATA_DIR}/shims/pecl channel-update pecl.php.net && \
        # printf "\n" | ${ASDF_DATA_DIR}/shims/pecl install redis excimer && \
        # echo 'extension=redis.so' > ${1}/8.3.9/etc/conf.d/redis.ini && \
        # echo 'extension=excimer.so' > ${1}/8.2.21/etc/conf.d/excimer.ini
fi
