#!/usr/bin/env bash
set -e

mkdir -p /etc/dnsmasq.d

upstream_nameservers=$(awk '/^nameserver/ {print $2}' /etc/resolv.conf | grep -v '^127\.0\.0\.1$' || true)

if [ -z "$upstream_nameservers" ]; then
    upstream_nameservers="1.1.1.1 8.8.8.8"
fi

: > /etc/dnsmasq.d/upstream.conf

for nameserver in $upstream_nameservers; do
    echo "server=$nameserver" >> /etc/dnsmasq.d/upstream.conf
done

printf 'nameserver 127.0.0.1\noptions ndots:0\n' > /etc/resolv.conf

echo "Starting dnsmasq..."
dnsmasq --conf-file=/etc/dnsmasq.conf

mkcert_ca_source=""

if [ -f /etc/nginx/certs/mkcert-rootCA.pem ]; then
    mkcert_ca_source="/etc/nginx/certs/mkcert-rootCA.pem"
elif [ -f /etc/nginx/certs/rootCA.pem ]; then
    mkcert_ca_source="/etc/nginx/certs/rootCA.pem"
fi

if [ -n "$mkcert_ca_source" ]; then
    echo "Installing mkcert CA into system trust store..."
    install -m 0644 "$mkcert_ca_source" /etc/pki/ca-trust/source/anchors/mkcert-local-rootCA.pem
    update-ca-trust extract
else
    echo "mkcert root CA not found in /etc/nginx/certs (expected mkcert-rootCA.pem or rootCA.pem)."
    echo "curl to *.test may fail with certificate verification errors."
fi

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
