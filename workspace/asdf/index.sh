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

/bin/sh -c "/opt/asdf/install-nodejs.sh ${ASDF_DATA_DIR}/installs/nodejs"
asdf global nodejs 18.11.0

# Install asdf php plugin and php versions if not installed
if [ ! -d "${ASDF_DATA_DIR}/plugins/php" ]; then
    asdf plugin add php https://github.com/Tarik02/asdf-php.git
fi

/bin/sh -c "/opt/asdf/install-php.sh ${ASDF_DATA_DIR}/installs/php"
asdf global php 8.1.13

# Asdf reshim
asdf reshim
