ARG POSTGRES_VERSION
FROM postgres:${POSTGRES_VERSION}

#####################################
# Copy configs
#####################################

COPY my.cnf /etc/postgresql/my.cnf

RUN chmod 0444 /etc/postgresql/my.cnf

#####################################
# Starting
#####################################

CMD ["postgres"]

EXPOSE 5432
