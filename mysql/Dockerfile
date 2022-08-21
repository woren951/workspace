ARG MYSQL_VERSION
FROM mysql:${MYSQL_VERSION}

#####################################
# Set Timezone
#####################################

ARG TZ=UTC

ENV TZ ${TZ}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && chown -R mysql:root /var/lib/mysql/

COPY my.cnf /etc/mysql/conf.d/my.cnf

RUN chmod 0444 /etc/mysql/conf.d/my.cnf

RUN mkdir /var/log/mysql && touch /var/log/mysql/slow.log

#####################################
# Percona Toolkit
#####################################

RUN apt-get --assume-yes update

RUN apt-get --assume-yes install percona-toolkit

# Run in container for generation slow log by percona toolkit
# pt-query-digest --limit=100% /var/log/mysql/mysql-slow.log > /var/log/mysql/pt-slow.log
# pt-query-digest --limit=100% --filter '$event->{user} =~ m/root/' /var/log/mysql/mysql-slow.log > /var/log/mysql/pt-root-slow.log

#####################################
# Starting
#####################################

CMD ["mysqld"]

EXPOSE 3306
