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

RUN pacman -Sy archlinux-keyring --noconfirm && pacman -Su --noconfirm

# Update packman database and dependencies
RUN pacman -Syyu --noconfirm

RUN pacman -S --needed --noconfirm base-devel

###########################################################################
# LOCALES
###########################################################################

USER root

COPY locales /usr/share/i18n/locales

RUN echo 'en_GB.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'de_DE.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'fr_FR.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen && \
    echo 'uk_UA.UTF-8 UTF-8' >> /etc/locale.gen

RUN locale-gen

###########################################################################
# TIMEZONE
###########################################################################

RUN ln -snf /usr/share/zoneinfo/Europe/Kiev /etc/localtime && \
    echo Europe/Kiev > /etc/timezone

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

RUN --mount=type=cache,target=/var/cache/python \
    pacman -S --noconfirm python

###########################################################################
# GO
###########################################################################

USER root

RUN --mount=type=cache,target=/var/cache/golang \
    pacman -S --noconfirm go

###########################################################################
# OTHER
###########################################################################

USER root

RUN pacman -S --noconfirm pkgconf oniguruma diffutils make autoconf bison re2c tidy postgresql-libs libsodium

###########################################################################
# VIRTUAL:WORLD
###########################################################################

USER root

RUN pacman -S --noconfirm libpng libjpeg gd imagemagick libxslt libzip libmcrypt libimagequant jpegoptim optipng ghostscript ffmpeg

###########################################################################
# USERS
###########################################################################

USER root

ARG PUID=1000
ENV PUID ${PUID}
ARG PGID=1000
ENV PGID ${PGID}

RUN groupadd -g ${PGID} web && \
    useradd -l -r -u ${PUID} -g web -m web && \
    usermod -p "*" web -s /bin/bash && \
    echo "web ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/web

###########################################################################
# YAY
###########################################################################

USER web

RUN cd /home/web && git clone https://aur.archlinux.org/yay.git && \
    cd yay && makepkg -sri --needed --noconfirm && cd - && \
    rm -rf .cache yay

###########################################################################
# ZSH
###########################################################################

USER root

RUN pacman -S --noconfirm zsh

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

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

USER web

RUN --mount=type=cache,target=/var/cache/google-chrome \
    yay -S --noconfirm google-chrome

###########################################################################
# LOCATE
###########################################################################

USER root

RUN pacman -S --noconfirm mlocate

RUN updatedb

###########################################################################
# XDEBUG
###########################################################################

USER root

RUN pacman -S --noconfirm xdebug

###########################################################################
# ASDF
###########################################################################

USER root

ENV ASDF_DATA_DIR="/var/.asdf"

ENV BASH_FILES="/root/.zshrc /root/.bashrc /home/web/.zshrc /home/web/.bashrc"

USER web

RUN yay -S --noconfirm asdf-vm

USER root

RUN echo "" | tee -a ${BASH_FILES} && \
    echo '# asdf' | tee -a ${BASH_FILES} && \
    echo 'source /opt/asdf-vm/asdf.sh' | tee -a ${BASH_FILES}

ENV PATH="/opt/asdf-vm/bin:${PATH}"

RUN asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git && \
    asdf plugin add php https://github.com/asdf-community/asdf-php.git

COPY php ${ASDF_DATA_DIR}/php-ini

RUN echo "" | tee -a ${BASH_FILES} && \
    echo '# asdf-switcher' | tee -a ${BASH_FILES} && \
    echo 'alias switch="bash /opt/switch.sh"' | tee -a ${BASH_FILES} && \
    echo '# asdf-nodejs' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-10="asdf global nodejs 10.24.1"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-12="asdf global nodejs 12.22.10"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-14="asdf global nodejs 14.19.0"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-16="asdf global nodejs 16.14.0"' | tee -a ${BASH_FILES} && \
    echo '# asdf-php' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-74="asdf global php 7.4.28"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-80="asdf global php 8.0.16"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-81="asdf global php 8.1.3"' | tee -a ${BASH_FILES}

USER root

RUN chown -R web: ${ASDF_DATA_DIR}

###########################################################################
# NPM
###########################################################################

USER root

RUN pacman -S --noconfirm npm && \
    npm install --global yarn gulp-cli grunt-cli

###########################################################################
# NGINX
###########################################################################

USER root

RUN pacman -S --noconfirm nginx

RUN touch /var/log/messages

COPY nginx/nginx.conf /etc/nginx/

COPY nginx/logrotate /etc/logrotate.d/

###########################################################################
# VSCODE-SERVER
###########################################################################

USER root

RUN mkdir -p /home/web/.vscode-server/extensions && \
    chown -R web /home/web/.vscode-server

###########################################################################
# STARTUP
###########################################################################

ADD --chown=web: ./switch.sh /opt/switch.sh

ADD ./install-nodejs.sh /opt/install-nodejs.sh
ADD ./install-php.sh /opt/install-php.sh
ADD ./startup.sh /opt/startup.sh

CMD [ "/bin/bash", "/opt/startup.sh" ]

WORKDIR /var/www
