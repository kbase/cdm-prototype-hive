FROM apache/hive:4.0.0

# https://github.com/apache/hive/blob/7f87a3b0ef5bd468df34fb4dd5bb4c4db2ac2245/packaging/src/docker/Dockerfile

USER root
RUN apt-get update; \
    apt-get -y install curl; \
    rm -rf /var/lib/apt/lists/*

# Remove log4j jars with cve-2021-4104 in the hadoop installation
RUN rm /opt/hadoop/share/hadoop/common/lib/log4j-1.2.17.jar && \
    rm /opt/hadoop/share/hadoop/hdfs/lib/log4j-1.2.17.jar

ENV POSTGRES_JAR=postgresql-42.6.2.jar

# License is BSD-2: https://jdbc.postgresql.org/license/
RUN curl https://jdbc.postgresql.org/download/$POSTGRES_JAR -o /opt/hive/lib/$POSTGRES_JAR

COPY scripts/entrypoint.sh /opt/kbase/
RUN chmod a+x /opt/kbase/entrypoint.sh

USER hive
ENTRYPOINT ["/opt/kbase/entrypoint.sh"]
