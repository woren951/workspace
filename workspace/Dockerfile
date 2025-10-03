###########################################################################
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
###########################################################################

FROM rockylinux:9.3-minimal

LABEL maintainer="Oleh Kotiai <woren951@gmail.com>"

###########################################################################
# Update core and dependencies
###########################################################################
USER root

RUN microdnf install dnf --assumeyes

RUN dnf upgrade --assumeyes

RUN dnf update --assumeyes

###########################################################################
# Install sudo
###########################################################################
USER root

RUN dnf install sudo --assumeyes

###########################################################################
# Setup timezone
###########################################################################
USER root

ENV TZ=Europe/Kyiv

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dnf install -y tzdata

###########################################################################
# Create new user
###########################################################################
USER root

RUN groupadd --gid 1000 web

RUN useradd --system --create-home --uid 1000 --gid 1000 --shell /bin/bash web && \
    usermod --password "*" web --shell /bin/bash && \
    echo "web ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers

###########################################################################
# Update system utils
###########################################################################
USER root

RUN dnf install findutils ncurses --assumeyes

###########################################################################
# Update tools
###########################################################################
USER root

RUN dnf install tar wget vi --assumeyes

###########################################################################
# Installing systemd
###########################################################################
USER root

RUN dnf install systemd --assumeyes

RUN mkdir -p /etc/systemd/system/multi-user.target.wants

###########################################################################
# Installing locales
###########################################################################
USER root

RUN dnf install glibc-langpack-uk --assumeyes

###########################################################################
# Update tools
###########################################################################
USER root

ARG GIT_GLOBAL_USER_NAME

ARG GIT_GLOBAL_USER_EMAIL

RUN dnf install git --assumeyes

RUN git config --global user.name "${GIT_GLOBAL_USER_NAME}" && \
    git config --global user.email "${GIT_GLOBAL_USER_EMAIL}"

###########################################################################
# Setup bash
###########################################################################
USER root

RUN mkdir -p /root/.bash-history && \
    mkdir -p /home/web/.bash-history && \
    chown -R web /home/web/.bash-history

RUN echo 'export HISTFILE=/root/.bash-history/.bash' | tee -a ~/.bashrc

USER web

RUN echo 'export HISTFILE=/home/web/.bash-history/.bash' | tee -a ~/.bashrc

###########################################################################
# Setup zsh
###########################################################################
USER root

RUN dnf install zsh --assumeyes

RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh

RUN sh install.sh

RUN git clone https://github.com/jessarcher/zsh-artisan.git ~/.oh-my-zsh/custom/plugins/artisan

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git artisan composer npm yarn history-substring-search)/' ~/.zshrc && \
    echo "" | tee -a ~/.zshrc && \
    echo "# history plugin configs" | tee -a ~/.zshrc && \
    echo 'export HISTFILE=/root/.bash-history/.zsh' | tee -a ~/.zshrc && \
    echo 'setopt HIST_IGNORE_ALL_DUPS' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"' | tee -a ~/.zshrc

USER web

RUN sh install.sh

RUN git clone https://github.com/jessarcher/zsh-artisan.git ~/.oh-my-zsh/custom/plugins/artisan

RUN sed -i -E 's/ZSH_THEME="(.+)"/ZSH_THEME="af-magic"/' ~/.zshrc && \
    sed -i -E 's/plugins=(.+)/plugins=(git artisan composer npm yarn history-substring-search)/' ~/.zshrc && \
    echo "" | tee -a ~/.zshrc && \
    echo "# history plugin configs" | tee -a ~/.zshrc && \
    echo 'export HISTFILE=/home/web/.bash-history/.zsh' | tee -a ~/.zshrc && \
    echo 'setopt HIST_IGNORE_ALL_DUPS' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"' | tee -a ~/.zshrc && \
    echo 'HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"' | tee -a ~/.zshrc

###########################################################################
# Local https
###########################################################################
USER root

RUN dnf install nss-tools --assumeyes

RUN curl -JLO "https://dl.filippo.io/mkcert/latest?for=linux/amd64" && \
    chmod +x mkcert-v*-linux-amd64 && \
    cp mkcert-v*-linux-amd64 /usr/local/bin/mkcert

###########################################################################
# Install and remi modules
###########################################################################
USER root

RUN dnf install https://rpms.remirepo.net/enterprise/remi-release-9.rpm --assumeyes

RUN dnf config-manager --set-enabled remi

###########################################################################
# Installing ssh server
###########################################################################
USER root

RUN dnf install openssh-server --assumeyes

RUN ssh-keygen -A

ADD ./ssh/ /root/.ssh/

ADD --chown=web: ./ssh/ /home/web/.ssh/

RUN sed -i -e 's/^UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config && \
    sed -i -e 's/^#PermitUserEnvironment no/PermitUserEnvironment yes/g' /etc/ssh/sshd_config && \
    sed -i -e 's/^#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

RUN cat /home/web/.ssh/id_ed25519.pub >> /home/web/.ssh/authorized_keys && \
    cat /home/web/.ssh/id_rsa.pub >> /home/web/.ssh/authorized_keys

RUN systemctl enable sshd.service

###########################################################################
# Install and run nginx
###########################################################################
USER root

RUN dnf install nginx --assumeyes

COPY nginx/nginx.conf /etc/nginx/

RUN systemctl enable nginx.service

###########################################################################
# Install and run php
###########################################################################
USER root

RUN dnf module enable php:remi-8.4 --assumeyes

RUN dnf install php php-bcmath php-cli php-common php-curl php-fpm php-gd php-gettext php-intl php-json php-mbstring php-mysqlnd php-opcache php-pdo php-pdo_mysql php-pgsql php-soap php-xml php-zip --assumeyes

RUN sed -i 's/user = apache/user = web/' /etc/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = web/' /etc/php-fpm.d/www.conf && \
    sed -i 's/listen.acl_users = apache,nginx/listen.acl_users = web,nginx/' /etc/php-fpm.d/www.conf && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' /etc/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 256M/' /etc/php.ini

RUN dnf install php83 php83-php-bcmath php83-php-cli php83-php-common php83-php-curl php83-php-fpm php83-php-gd php83-php-gettext php83-php-intl php83-php-json php83-php-mbstring php83-php-mysqlnd php83-php-opcache php83-php-pdo php83-php-pdo_mysql php83-php-pgsql php83-php-soap php83-php-xml php83-php-zip --assumeyes

RUN sed -i 's/user = apache/user = web/' /etc/opt/remi/php83/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = web/' /etc/opt/remi/php83/php-fpm.d/www.conf && \
    sed -i 's/listen.acl_users = apache/listen.acl_users = web,nginx/' /etc/opt/remi/php83/php-fpm.d/www.conf && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' /etc/opt/remi/php83/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 256M/' /etc/opt/remi/php83/php.ini

RUN dnf install php82 php82-php-bcmath php82-php-cli php82-php-common php82-php-curl php82-php-fpm php82-php-gd php82-php-gettext php82-php-intl php82-php-json php82-php-mbstring php82-php-mysqlnd php82-php-opcache php82-php-pdo php82-php-pdo_mysql php82-php-pgsql php82-php-soap php82-php-xml php82-php-zip --assumeyes

RUN sed -i 's/user = apache/user = web/' /etc/opt/remi/php82/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = web/' /etc/opt/remi/php82/php-fpm.d/www.conf && \
    sed -i 's/listen.acl_users = apache/listen.acl_users = web,nginx/' /etc/opt/remi/php82/php-fpm.d/www.conf && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' /etc/opt/remi/php82/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 256M/' /etc/opt/remi/php82/php.ini

RUN dnf install php74 php74-php-bcmath php74-php-cli php74-php-common php74-php-curl php74-php-fpm php74-php-gd php74-php-gettext php74-php-intl php74-php-json php74-php-mbstring php74-php-mysqlnd php74-php-opcache php74-php-pdo php74-php-pdo_mysql php74-php-pgsql php74-php-soap php74-php-xml php74-php-zip --assumeyes

RUN sed -i 's/user = apache/user = web/' /etc/opt/remi/php74/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = web/' /etc/opt/remi/php74/php-fpm.d/www.conf && \
    sed -i 's/listen.acl_users = apache/listen.acl_users = web,nginx/' /etc/opt/remi/php74/php-fpm.d/www.conf && \
    sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 256M/' /etc/opt/remi/php74/php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 256M/' /etc/opt/remi/php74/php.ini

RUN systemctl enable php74-php-fpm.service && \
    systemctl enable php82-php-fpm.service && \
    systemctl enable php83-php-fpm.service && \
    systemctl enable php-fpm.service

###########################################################################
# Install nodejs
###########################################################################
USER web

ENV VOLTA_HOME=/home/web/.volta

RUN curl https://get.volta.sh | bash

RUN /home/web/.volta/bin/volta install node@16.20.2 node@18.19.0 node@20.10.0 node@23.8.0 yarn

ENV PATH="${VOLTA_HOME}/bin:${PATH}"

###########################################################################
# Running system
###########################################################################
USER root

STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]

WORKDIR /var/www
