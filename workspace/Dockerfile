###########################################################################
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
###########################################################################

FROM archlinux:base

LABEL maintainer="Oleh Kotiai <woren951@gmail.com>"

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
# ZIP
###########################################################################

USER root

RUN pacman -S --noconfirm gzip unzip

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

RUN ssh-keygen -A

RUN sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

###########################################################################
# OPENSSL
###########################################################################

USER root

RUN pacman -S --noconfirm openssl-1.1

###########################################################################
# PYTHON
###########################################################################

USER root

RUN --mount=type=cache,target=/var/cache/python \
    pacman -S --noconfirm python python-pip

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
# BASH
###########################################################################

USER root

RUN mkdir -p /root/.bash-history && \
    mkdir -p /home/web/.bash-history && \
    chown -R web /home/web/.bash-history

RUN echo 'export HISTFILE=/root/.bash-history/.bash' | tee -a ~/.bashrc

USER web

RUN echo 'export HISTFILE=/home/web/.bash-history/.bash' | tee -a ~/.bashrc

###########################################################################
# ZSH
###########################################################################

USER root

RUN pacman -S --noconfirm zsh

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

RUN sh install.sh

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git asdf laravel5 npm yarn history-substring-search)/' ~/.zshrc && \
    echo "" | tee -a ~/.zshrc && \
    echo "# history plugin configs" | tee -a ~/.zshrc && \
    echo 'export HISTFILE=/root/.bash-history/.zsh' | tee -a ~/.zshrc && \
    echo 'setopt HIST_IGNORE_ALL_DUPS' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"' | tee -a ~/.zshrc

USER web

RUN sh install.sh

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git asdf laravel5 npm yarn history-substring-search)/' ~/.zshrc && \
    echo "" | tee -a ~/.zshrc && \
    echo "# history plugin configs" | tee -a ~/.zshrc && \
    echo 'export HISTFILE=/home/web/.bash-history/.zsh' | tee -a ~/.zshrc && \
    echo 'setopt HIST_IGNORE_ALL_DUPS' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"' | tee -a ~/.zshrc

###########################################################################
# GOOGLE CHROME
###########################################################################

# USER web

# RUN --mount=type=cache,target=/var/cache/google-chrome \
#     yay -S --noconfirm google-chrome

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

ENV BASH_FILES="/root/.zshrc /root/.bashrc /home/web/.zshrc /home/web/.bashrc"

ENV ASDF_DIR="/home/.asdf/vm"
RUN mkdir -p ${ASDF_DIR}

ENV ASDF_DATA_DIR="/home/.asdf/data"
RUN mkdir -p ${ASDF_DATA_DIR}

ENV PATH="${ASDF_DIR}/bin:${PATH}"

RUN echo "" | tee -a ${BASH_FILES} && \
    echo '# asdf' | tee -a ${BASH_FILES} && \
    echo 'source ${ASDF_DIR}/asdf.sh' | tee -a ${BASH_FILES}

RUN echo "" | tee -a ${BASH_FILES} && \
    echo '# asdf-switcher' | tee -a ${BASH_FILES} && \
    echo 'alias switch="bash /opt/switch.sh"' | tee -a ${BASH_FILES} && \
    echo '# asdf-nodejs' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-10="asdf global nodejs 10.24.1"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-12="asdf global nodejs 12.22.12"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-14="asdf global nodejs 14.21.3"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-16="asdf global nodejs 16.20.2"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-18="asdf global nodejs 18.17.1"' | tee -a ${BASH_FILES} && \
    echo 'alias use-nodejs-20="asdf global nodejs 20.6.1"' | tee -a ${BASH_FILES} && \
    echo '# asdf-php' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-56="asdf global php 5.6.40"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-74="asdf global php 7.1.33"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-74="asdf global php 7.4.33"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-80="asdf global php 8.0.26"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-81="asdf global php 8.1.13"' | tee -a ${BASH_FILES} && \
    echo 'alias use-php-81="asdf global php 8.2.10"' | tee -a ${BASH_FILES}

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
# LOCALHTTPS
###########################################################################

USER root

RUN pip install localhttps --break-system-packages

###########################################################################
# STARTUP
###########################################################################

ADD --chown=web: ./switch.sh /opt/switch.sh

ADD ./install-nodejs.sh /opt/install-nodejs.sh
ADD ./install-php.sh /opt/install-php.sh
ADD ./startup.sh /opt/startup.sh

CMD [ "su", "web", "/opt/startup.sh" ]

WORKDIR /var/www
