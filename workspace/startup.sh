#!/bin/bash

# # Copy shared files
# cp -r /home/web/.web-shared/. /home/web/

# Trust localhttps certificates
trust anchor --store ${LOCALHTTPS_DATA}/CertificationAuthorities/default.pem

# Configuration asdf for web user
chown -R web: ${ASDF_DIR}
chown -R web: ${ASDF_DATA_DIR}

# Systemctl enabling and starting
mount -o remount,rw /sys/fs/cgroup
mount -o remount,exec /tmp

mkdir /etc/systemd/system/multi-user.target.wants

cp /etc/systemd/web/main.service /etc/systemd/system/main.service
ln -sf /etc/systemd/system/main.service /etc/systemd/system/multi-user.target.wants/main.service

# Start systemd
exec /usr/lib/systemd/systemd

# # Start php-fpm in foreground
# sudo ${ASDF_DATA_DIR}/installs/php/5.6.40/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/7.1.33/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/7.4.33/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.0.26/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.1.13/sbin/php-fpm
# sudo ${ASDF_DATA_DIR}/installs/php/8.2.1/sbin/php-fpm
