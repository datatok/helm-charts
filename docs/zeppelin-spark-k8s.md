## Add Spark dependencies via packages

Context: Zeppelin server create a pod with Zeppelin Spark interpreter, submitted as Spark application via ``spark-submit``.

In order to configure packages, configure the Zeppelin Spark conf like this:

```
SPARK_SUBMIT_OPTIONS: --packages org.elasticsearch:elasticsearch-spark-30_2.12:7.17.1
# To use HTTP proxy
ZEPPELIN_INTP_JAVA_OPTS: -Dhttp.proxyHost=XXXX -Dhttp.proxyPort=2001 -Dhttps.proxyHost=XXXX -Dhttps.proxyPort=2001 -Dhttp.noProxy=10.100.*
```

jars will be downloaded inside ``/opt/zeppelin/.ivy2`` directory.
