FROM    alpine:3.3

# Here we use several hacks collected from https://github.com/gliderlabs/docker-alpine/issues/11:
# # 1. install GLibc (which is not the cleanest solution at all) 


# Build variables
ENV     FILEBEAT_VERSION 5.1.1
ENV     FILEBEAT_NAME filebeat-${FILEBEAT_VERSION}-linux-x86_64
ENV     FILEBEAT_URL https://artifacts.elastic.co/downloads/beats/filebeat/${FILEBEAT_NAME}.tar.gz

# Environment variables
ENV     FILEBEAT_HOME /opt/${FILEBEAT_NAME}
ENV     PATH $PATH:${FILEBEAT_HOME}

WORKDIR /opt/

RUN apk --update add curl tar jq

RUN     curl -sL ${FILEBEAT_URL} | tar xz -C .
ADD     filebeat.yml ${FILEBEAT_HOME}/
ADD     docker-entrypoint.sh    /entrypoint.sh
RUN     chmod +x /entrypoint.sh

ENTRYPOINT  ["/entrypoint.sh"]
CMD         ["start"]
