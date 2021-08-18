# helm-data-lake
Helm chart to run Apache Zeppelin with Apache Spark

Build your own data-lake! 

## Apache Spark

``spark-cluster`` Helm chart create a Spark cluster, with a master and X workers.

## Zeppelin

``zeppelin`` Helm chart will run Zeppelin webui server.

Spark interpreter will run as a separate pod, because it can crash (most of the time because OOM).
