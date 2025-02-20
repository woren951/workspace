#!/bin/bash

# Configuration asdf for web user
sudo chown -R web: ${ASDF_DIR}
sudo chown -R web: ${ASDF_DATA_DIR}

# Install asdf if not installed
if [ ! -f "${ASDF_DIR}/asdf.sh" ]; then
    git clone https://github.com/asdf-vm/asdf.git ${ASDF_DIR} --branch v0.10.2
fi

# Install asdf nodejs plugin and nodejs versions if not installed
if [ ! -d "${ASDF_DATA_DIR}/plugins/nodejs" ]; then
    asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi

bash /opt/install-nodejs.sh ${ASDF_DATA_DIR}/installs/nodejs
asdf global nodejs 20.10.0

# # Install asdf php plugin and php versions if not installed
# if [ ! -d "${ASDF_DATA_DIR}/plugins/php" ]; then
#     asdf plugin add php https://github.com/woren951/asdf-php.git
# fi

# bash /opt/install-php.sh ${ASDF_DATA_DIR}/installs/php ${ASDF_DATA_DIR}
# asdf global php 8.3.9

# Asdf reshim
asdf reshim

# Copy shared files
cp -r /home/web/.web-shared/. /home/web/

# Start sshd in foreground
sudo /usr/sbin/sshd

# Start php-fpm in foreground
# sudo ${ASDF_DATA_DIR}/installs/php/5.6.40/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/7.1.33/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/7.4.33/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.0.26/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.1.29/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.2.21/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.3.9/sbin/php-fpm

sudo /opt/php/buildroot/bin/php-fpm

# Trust localhttps certificates
# sudo trust anchor --store ${LOCALHTTPS_DATA}/CertificationAuthorities/default.pem

# Start nginx in foreground
sudo nginx
