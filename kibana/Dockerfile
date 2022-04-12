ARG ELK_VERSION
FROM kibana:${ELK_VERSION}

###########################################################################
# FILEBEAT
###########################################################################

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

COPY filebeat-modules/nginx.yml $FILEBEAT_DIR/modules.d/nginx.yml

###########################################################################
# FILEBEAT MYSQL
###########################################################################

RUN cd ${FILEBEAT_DIR} && ./filebeat modules enable mysql

COPY filebeat-modules/mysql.yml $FILEBEAT_DIR/modules.d/mysql.yml

# RUN ${FILEBEAT_DIR}/filebeat modules enable postgresql redis

# RUN cd ${FILEBEAT_DIR} && ./filebeat setup && ./filebeat -e

EXPOSE 5601
