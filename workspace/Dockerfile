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

RUN pacman -S --noconfirm pkgconf oniguruma diffutils make autoconf bison re2c tidy postgresql-libs

###########################################################################
# VIRTUAL:WORLD
###########################################################################

USER root

RUN pacman -S --noconfirm libpng libjpeg gd imagemagick libxslt libzip libmcrypt

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

USER main

RUN yay -S asdf-vm

USER root

RUN echo "" >> ~/.zshrc >> ~/.bashrc && \
    echo '# asdf' >> ~/.zshrc >> ~/.bashrc && \
    echo 'source /opt/asdf-vm/asdf.sh' >> ~/.zshrc >> ~/.bashrc

ENV PATH="/opt/asdf-vm/bin:$PATH"

USER web

RUN echo "" >> ~/.bashrc >> ~/.zshrc && \
    echo '# asdf' >> ~/.bashrc >> ~/.zshrc && \
    echo 'source /opt/asdf-vm/asdf.sh' >> ~/.bashrc >> ~/.zshrc

ENV PATH="/opt/asdf-vm/bin:$PATH"

###########################################################################
# NODE
###########################################################################

USER root

RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

RUN asdf install nodejs 10.24.1 && \
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

# RUN asdf install php 7.1.33

# RUN cp $HOME/.asdf/installs/php/7.1.33/php-fpm.conf.default $HOME/.asdf/installs/php/7.1.33/php-fpm.conf && \
#     cp $HOME/.asdf/installs/php/7.1.33/php-fpm.d/www.conf.default $HOME/.asdf/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9071/' $HOME/.asdf/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/user = www-data/user = web/' $HOME/.asdf/installs/php/7.1.33/php-fpm.d/www.conf && \
#     sed -i 's/group = www-data/group = web/' $HOME/.asdf/installs/php/7.1.33/php-fpm.d/www.conf

RUN asdf install php 7.4.28

RUN cp $HOME/.asdf/installs/php/7.4.28/php-fpm.conf.default $HOME/.asdf/installs/php/7.4.28/php-fpm.conf && \
    cp $HOME/.asdf/installs/php/7.4.28/php-fpm.d/www.conf.default $HOME/.asdf/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9074/' $HOME/.asdf/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $HOME/.asdf/installs/php/7.4.28/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $HOME/.asdf/installs/php/7.4.28/php-fpm.d/www.conf

RUN asdf install php 8.0.16

RUN cp $HOME/.asdf/installs/php/8.0.16/php-fpm.conf.default $HOME/.asdf/installs/php/8.0.16/php-fpm.conf && \
    cp $HOME/.asdf/installs/php/8.0.16/php-fpm.d/www.conf.default $HOME/.asdf/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9080/' $HOME/.asdf/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $HOME/.asdf/installs/php/8.0.16/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $HOME/.asdf/installs/php/8.0.16/php-fpm.d/www.conf

RUN asdf install php 8.1.3

RUN cp $HOME/.asdf/installs/php/8.1.3/php-fpm.conf.default $HOME/.asdf/installs/php/8.1.3/php-fpm.conf && \
    cp $HOME/.asdf/installs/php/8.1.3/php-fpm.d/www.conf.default $HOME/.asdf/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/listen = 127.0.0.1:9000/listen = 127.0.0.1:9081/' $HOME/.asdf/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/user = www-data/user = web/' $HOME/.asdf/installs/php/8.1.3/php-fpm.d/www.conf && \
    sed -i 's/group = www-data/group = web/' $HOME/.asdf/installs/php/8.1.3/php-fpm.d/www.conf

###########################################################################
# ASDF POST-INSTALL
###########################################################################

USER root

RUN cp -R /root/.asdf /home/web/.asdf

RUN chown -R web:web /home/web/.asdf

RUN asdf global php 8.1.3

RUN asdf global nodejs 16.14.0

RUN echo "" >> ~/.zshrc >> ~/.bashrc && \
    echo '# asdf-nodejs' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-10="asdf global nodejs 10.24.1"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-12="asdf global nodejs 12.22.10"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-14="asdf global nodejs 14.19.0"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-16="asdf global nodejs 16.14.0"' >> ~/.zshrc >> ~/.bashrc && \
    echo '# asdf-php' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-74="asdf global php 7.4.28"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-80="asdf global php 8.0.16"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-81="asdf global php 8.1.3"' >> ~/.zshrc >> ~/.bashrc

USER web

RUN asdf global php 8.1.3

RUN asdf global nodejs 16.14.0

RUN echo "" >> ~/.zshrc >> ~/.bashrc && \
    echo '# asdf-nodejs' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-10="asdf global nodejs 10.24.1"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-12="asdf global nodejs 12.22.10"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-14="asdf global nodejs 14.19.0"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-node-16="asdf global nodejs 16.14.0"' >> ~/.zshrc >> ~/.bashrc && \
    echo '# asdf-php' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-74="asdf global php 7.4.28"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-80="asdf global php 8.0.16"' >> ~/.zshrc >> ~/.bashrc && \
    echo 'alias use-php-81="asdf global php 8.1.3"' >> ~/.zshrc >> ~/.bashrc

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
