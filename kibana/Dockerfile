ARG ELK_VERSION
FROM kibana:${ELK_VERSION}

#####################################
# Set Timezone
#####################################

# USER root

# RUN apt-get update && apt-get install -y tzdata

# ARG TZ=UTC

# ENV TZ ${TZ}

# RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

###########################################################################
# FILEBEAT
###########################################################################

USER kibana

ARG ELK_VERSION ELK_HOST KIBANA_HOST

ENV FILEBEAT_DIR /usr/share/kibana/filebeat

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${ELK_VERSION}-linux-x86_64.tar.gz && \
    tar xzvf filebeat-${ELK_VERSION}-linux-x86_64.tar.gz && \
    mv filebeat-${ELK_VERSION}-linux-x86_64 ${FILEBEAT_DIR} && \
    rm filebeat-${ELK_VERSION}-linux-x86_64.tar.gz

RUN sed -i "s/localhost:9200/${ELK_HOST}:9200/" ${FILEBEAT_DIR}/filebeat.yml && \
    sed -i "s/#host: \"localhost:5601\"/host: \"${KIBANA_HOST}:5601\"/" ${FILEBEAT_DIR}/filebeat.yml

###########################################################################
# FILEBEAT NGINX
###########################################################################

RUN cd ${FILEBEAT_DIR} && ./filebeat modules enable nginx

COPY --chown=kibana:root filebeat-modules/nginx.yml $FILEBEAT_DIR/modules.d/nginx.yml

RUN chmod go-w $FILEBEAT_DIR/modules.d/nginx.yml

###########################################################################
# FILEBEAT MYSQL
###########################################################################

RUN cd ${FILEBEAT_DIR} && ./filebeat modules enable mysql

COPY --chown=kibana:root filebeat-modules/mysql.yml $FILEBEAT_DIR/modules.d/mysql.yml

RUN chmod go-w $FILEBEAT_DIR/modules.d/mysql.yml

###########################################################################
# MANUAL EXECUTION
#
# https://github.com/elastic/beats/blob/8.2/filebeat/module/nginx/access/ingest/pipeline.yml
# https://github.com/elastic/elasticsearch/blob/main/libs/grok/src/main/resources/patterns/legacy/grok-patterns
# cd ${FILEBEAT_DIR} && ./filebeat setup && ./filebeat -e
###########################################################################

EXPOSE 5601
