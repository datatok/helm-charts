# helm-data-lake
Helm chart to run Apache Zeppelin with Apache Spark

Build your own data-lake! 

## Apache Spark

``spark-cluster`` Helm chart create a Spark cluster, with a master and X workers.

## Zeppelin

``zeppelin`` Helm chart will run Zeppelin webui server.

Spark interpreter will run as a separate pod, because it can crash (most of the time because OOM).

## Troubleshoot

### Hive integration

To test Spark + Hive

```
$SPARK_HOME/bin/spark-shell --driver-java-options "-Dderby.system.home=/tmp/derby" --conf spark.hive.metastore.uris=thrift://10.100.XX.XX:9083 --conf spark.sql.warehouse.dir=/tmp

val sqlContext = new org.apache.spark.sql.hive.HiveContext(sc)
sqlContext.sql("show tables").show()

spark.catalog.listDatabases().show()
spark.catalog.listTables().show()
```

val spark = SparkSession.builder().appName("Spark Hive Example").master("local[*]").config("hive.metastore.uris", "thrift://localhost:9083").enableHiveSupport().getOrCreate()