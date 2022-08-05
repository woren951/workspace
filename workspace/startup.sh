#!/bin/bash

# Install nodejs
bash /opt/install-nodejs.sh ${ASDF_DATA_DIR}/installs/nodejs
asdf global nodejs 16.14.0

# Install php
bash /opt/install-php.sh ${ASDF_DATA_DIR}/installs/php
asdf global php 8.1.3

# Configuration asdf for web user
cp /root/.tool-versions /home/web/.tool-versions
chown -R web: /home/web/.tool-versions
chown -R web: ${ASDF_DATA_DIR}
asdf reshim

# Start php-fpm in foreground
${ASDF_DATA_DIR}/installs/php/7.4.28/sbin/php-fpm
${ASDF_DATA_DIR}/installs/php/8.0.16/sbin/php-fpm
${ASDF_DATA_DIR}/installs/php/8.1.3/sbin/php-fpm

# Trust localhttps certificates
sudo trust anchor --store ${LOCALHTTPS_DATA}/CertificationAuthorities/default.pem

# Start nginx in foreground
nginx
