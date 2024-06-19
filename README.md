# Hive Metastore server

This is a docker image build for the remote Hive Metastore to customize the image for our purposes.
In particular it installs a postgres driver and splits up the service opts env var.

## Notes

* It appears that Spark [doesn't support 4.0.0 yet](https://spark.apache.org/docs/latest/sql-data-sources-hive-tables.html#interacting-with-different-versions-of-hive-metastore) (?)
