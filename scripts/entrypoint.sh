#!/bin/sh

# TODO: Check the server actually works, which is hard to find docs w/ an example
# TODO: GHA build

export SERVICE_NAME=metastore
export DB_DRIVER=postgres
export SERVICE_OPTS="
    -Djavax.jdo.option.ConnectionDriverName=org.postgresql.Driver
    -Djavax.jdo.option.ConnectionURL=jdbc:postgresql://$POSTGRES_HOST/$POSTGRES_DB
    -Djavax.jdo.option.ConnectionUserName=$POSTGRES_USER
    -Djavax.jdo.option.ConnectionPassword=$POSTGRES_PASSWORD"

# https://github.com/apache/hive/blob/7f87a3b0ef5bd468df34fb4dd5bb4c4db2ac2245/packaging/src/docker/Dockerfile
/entrypoint.sh
