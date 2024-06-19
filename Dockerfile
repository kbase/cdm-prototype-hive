FROM apache/hive:3.1.3

# https://github.com/apache/hive/blob/7f87a3b0ef5bd468df34fb4dd5bb4c4db2ac2245/packaging/src/docker/Dockerfile

USER root
RUN apt-get update; \
    apt-get -y install curl; \
    rm -rf /var/lib/apt/lists/*

ENV POSTGRES_JAR=postgresql-42.6.2.jar

# License is BSD-2: https://jdbc.postgresql.org/license/
RUN curl https://jdbc.postgresql.org/download/$POSTGRES_JAR -o /opt/hive/lib/$POSTGRES_JAR

COPY scripts/entrypoint.sh /opt/kbase/
RUN chmod a+x /opt/kbase/entrypoint.sh

USER hive
ENTRYPOINT ["/opt/kbase/entrypoint.sh"]
