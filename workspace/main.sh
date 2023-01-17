# Copy shared files
cp -r /home/web/.web-shared/. /home/web/

# Trust localhttps certificates
sudo trust anchor --store ${LOCALHTTPS_DATA}/CertificationAuthorities/default.pem
