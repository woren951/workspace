###########################################################################
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
###########################################################################

FROM archlinux:base

# Start as root
USER root

# Generate packman key
RUN pacman-key --init

# Update packman database and dependencies
RUN pacman -Syyu --noconfirm

RUN pacman -S --needed --noconfirm base-devel

###########################################################################
# LOCALES
###########################################################################

USER root

COPY locales /usr/share/i18n/locales

RUN echo 'de_DE.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'uk_UA.UTF-8 UTF-8' >> /etc/locale.gen

RUN locale-gen

###########################################################################
# VI
###########################################################################

USER root

RUN pacman -S --noconfirm vi

###########################################################################
# WGET
###########################################################################

USER root

RUN pacman -S --noconfirm wget

###########################################################################
# GZIP
###########################################################################

USER root

RUN pacman -S --noconfirm gzip

###########################################################################
# GIT
###########################################################################

USER root

RUN pacman -S --noconfirm git

###########################################################################
# OPENSSH
###########################################################################

USER root

RUN pacman -S --noconfirm openssh

###########################################################################
# PYTHON
###########################################################################

USER root

RUN pacman -S --noconfirm python

###########################################################################
# GO
###########################################################################

USER root

RUN pacman -S --noconfirm go

###########################################################################
# OTHER
###########################################################################

USER root

RUN pacman -S --noconfirm pkgconf oniguruma diffutils make autoconf bison re2c tidy postgresql-libs libsodium

###########################################################################
# VIRTUAL:WORLD
###########################################################################

USER root

RUN pacman -S --noconfirm libpng libjpeg gd imagemagick libxslt libzip libmcrypt libimagequant

###########################################################################
# USERS
###########################################################################

USER root

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} web && \
    useradd -l -u ${PUID} -g web -m web && \
    usermod -p "*" web -s /bin/bash

ADD add-aur.sh /root

RUN bash /root/add-aur.sh 'main' 'yay'

RUN yay -Syu --timeupdate

###########################################################################
# ZSH
###########################################################################

USER root

RUN pacman -S --noconfirm zsh

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

RUN sh install.sh

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git asdf laravel npm yarn)/' ~/.zshrc

USER main

RUN sh install.sh

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git asdf laravel npm yarn)/' ~/.zshrc

USER web

RUN sh install.sh

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git asdf laravel npm yarn)/' ~/.zshrc

###########################################################################
# GOOGLE CHROME
###########################################################################

USER main

RUN yay -S --noconfirm google-chrome

###########################################################################
# LOCATE
###########################################################################

USER root

RUN pacman -S --noconfirm mlocate

RUN updatedb

###########################################################################
# ASDF
###########################################################################

USER root

ENV ASDF_DATA_DIR="/var/.asdf"

USER main

RUN yay -S asdf-vm

USER root

RUN echo "" | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'source /opt/asdf-vm/asdf.sh' | tee -a ~/.zshrc ~/.bashrc

ENV PATH="/opt/asdf-vm/bin:$PATH"

USER web

RUN echo "" | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'source /opt/asdf-vm/asdf.sh' | tee -a ~/.zshrc ~/.bashrc

ENV PATH="/opt/asdf-vm/bin:$PATH"

###########################################################################
# NODE
###########################################################################

USER root

RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

RUN --mount=type=cache,target=/var/cache/asdf/nodejs \
    asdf install nodejs 10.24.1 && \
    asdf install nodejs 12.22.10 && \
    asdf install nodejs 14.19.0 && \
    asdf install nodejs 16.14.0

###########################################################################
# PHP
###########################################################################

USER root

RUN asdf plugin-add php https://github.com/asdf-community/asdf-php.git

# ENV CXX="g++ -DTRUE=1 -DFALSE=0"
# ENV CC="gcc -DTRUE=1 -DFALSE=0"

# ENV CFLAGS=-DU_DEFINE_FALSE_AND_TRUE=1
# ENV CXXFLAGS=-DU_DEFINE_FALSE_AND_TRUE=1

# RUN --mount=type=cache,target=/var/cache/asdf/php-71 \
#     asdf install php 7.1.33

# RUN cp $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.conf.default $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.conf && \
#     cp $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.d/www.conf.default $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9071/' $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/user = www-data/user = web/' $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/group = www-data/group = web/' $ASDF_DATA_DIR/installs/php/7.1.33/php-fpm.d/www.conf

# COPY php/php7.1.ini $ASDF_DATA_DIR/installs/php/7.1.33/conf.d/php.ini

# RUN asdf global php 7.1.33 && \
#     $ASDF_DATA_DIR/shims/pecl install libsodium imagick && \
#     echo 'extension=sodium.so' > $ASDF_DATA_DIR/installs/php/7.1.33/conf.d/sodium.ini && \
#     echo 'extension=imagick.so' > $ASDF_DATA_DIR/installs/php/7.1.33/conf.d/imagick.ini

RUN --mount=type=cache,target=/var/cache/asdf/php-74 \
    asdf install php 7.4.28

RUN cp $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.conf.default $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.conf && \
    cp $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.d/www.conf.default $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9074/' $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $ASDF_DATA_DIR/installs/php/7.4.28/php-fpm.d/www.conf

COPY php/php7.4.ini $ASDF_DATA_DIR/installs/php/7.4.28/conf.d/php.ini

RUN asdf global php 7.4.28 && \
    $ASDF_DATA_DIR/shims/pecl install libsodium imagick && \
    echo 'extension=sodium.so' > $ASDF_DATA_DIR/installs/php/7.4.28/conf.d/sodium.ini && \
    echo 'extension=imagick.so' > $ASDF_DATA_DIR/installs/php/7.4.28/conf.d/imagick.ini

RUN --mount=type=cache,target=/var/cache/asdf/php-80 \
    asdf install php 8.0.16

RUN cp $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.conf.default $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.conf && \
    cp $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.d/www.conf.default $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9080/' $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $ASDF_DATA_DIR/installs/php/8.0.16/php-fpm.d/www.conf

COPY php/php8.0.ini $ASDF_DATA_DIR/installs/php/8.0.16/conf.d/php.ini

RUN asdf global php 8.0.16 && \
    $ASDF_DATA_DIR/shims/pecl install imagick && \
    echo 'extension=imagick.so' > $ASDF_DATA_DIR/installs/php/8.0.16/conf.d/imagick.ini

RUN --mount=type=cache,target=/var/cache/asdf/php-81 \
    asdf install php 8.1.3

RUN cp $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.conf.default $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.conf && \
    cp $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.d/www.conf.default $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9081/' $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $ASDF_DATA_DIR/installs/php/8.1.3/php-fpm.d/www.conf

COPY php/php8.1.ini $ASDF_DATA_DIR/installs/php/8.1.3/conf.d/php.ini

RUN asdf global php 8.1.3 && \
    $ASDF_DATA_DIR/shims/pecl install imagick && \
    echo 'extension=imagick.so' > $ASDF_DATA_DIR/installs/php/8.1.3/conf.d/imagick.ini

###########################################################################
# ASDF POST-INSTALL
###########################################################################

USER root

RUN asdf global php 8.1.3

RUN asdf global nodejs 16.14.0

RUN echo "" | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf-nodejs' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-10="asdf global nodejs 10.24.1"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-12="asdf global nodejs 12.22.10"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-14="asdf global nodejs 14.19.0"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-16="asdf global nodejs 16.14.0"' | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf-php' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-74="asdf global php 7.4.28"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-80="asdf global php 8.0.16"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-81="asdf global php 8.1.3"' | tee -a ~/.zshrc ~/.bashrc

USER web

RUN asdf global php 8.1.3

RUN asdf global nodejs 16.14.0

RUN echo "" | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf-nodejs' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-10="asdf global nodejs 10.24.1"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-12="asdf global nodejs 12.22.10"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-14="asdf global nodejs 14.19.0"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-node-16="asdf global nodejs 16.14.0"' | tee -a ~/.zshrc ~/.bashrc && \
    echo '# asdf-php' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-74="asdf global php 7.4.28"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-80="asdf global php 8.0.16"' | tee -a ~/.zshrc ~/.bashrc && \
    echo 'alias use-php-81="asdf global php 8.1.3"' | tee -a ~/.zshrc ~/.bashrc

###########################################################################
# NPM
###########################################################################

USER root

RUN pacman -S --noconfirm npm

RUN npm install --global yarn gulp-cli grunt-cli

###########################################################################
# NGINX
###########################################################################

USER root

RUN pacman -S --noconfirm nginx

RUN touch /var/log/messages

COPY nginx/nginx.conf /etc/nginx/

COPY nginx/logrotate /etc/logrotate.d/

###########################################################################
# Startup script
###########################################################################

ADD ./startup.sh /opt/startup.sh

RUN sed -i 's/\r//g' /opt/startup.sh

CMD ["/bin/bash", "/opt/startup.sh"]

# Set default work directory
WORKDIR /var/www
