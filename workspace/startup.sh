#!/bin/bash

# Copy shared files
cp -r /home/web/.web-shared/. /home/web/

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
