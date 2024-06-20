# Hive Metastore server

This is a docker image build for the remote Hive Metastore to customize the image for our purposes.
In particular it installs a postgres driver and splits up the service opts env var.

## Notes

* Haven't looked into authentication to the metastore.
  * W/O auth anyone with access to the port could delete all the metadata.
  * That being said, anyone reading data needs read privs, anyone uploading data needs write to
    a DB. Not sure how HMS privs work - is is an all or nothing type of thing?
* It appears that Spark [doesn't support 4.0.0 yet](https://spark.apache.org/docs/latest/sql-data-sources-hive-tables.html#interacting-with-different-versions-of-hive-metastore) (?)

## Testing that the metastore works:

Requires python 3.11.

```
$ docker-compose up -d --build
$ pipenv install
$ pipenv shell
$ ipython
Python 3.11.3 (main, Apr  5 2023, 14:14:40) [GCC 7.5.0]
Type 'copyright', 'credits' or 'license' for more information
IPython 8.25.0 -- An enhanced Interactive Python. Type '?' for help.

In [1]: from hive_metastore_client import HiveMetastoreClient

In [2]: from hive_metastore_client.builders import DatabaseBuilder

In [3]: with HiveMetastoreClient("localhost", 9083) as hmc:
   ...:     hmc.create_database(DatabaseBuilder(name="whoo").build())
   ...: 

In [4]: with HiveMetastoreClient("localhost", 9083) as hmc:
   ...:     res = hmc.get_all_databases()
   ...: 

In [5]: res
Out[5]: ['default', 'whoo']
```
