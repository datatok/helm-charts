# dataTok Helm charts

High quality Helm charts to run data stuff on kubernetes! Even to build your own data-lake! 

* [RabbitMQ](./charts/rabbitmq)
* [Apache Zeppelin](./charts/zeppelin)
* [Apache Spark history](./charts/spark-history)
* [Apache Spark cluster](./charts/spark-cluster)
* [Apache Spark master](./charts/spark-master)
* [Apache Spark worker](./charts/spark-work)
* [elasticsearch provisionner](./charts/es-proviz)

## Usage

Add repository: **https://datatok.github.io/helm-charts/**

```
# charts.yaml
apiVersion: v2
name: conso-es-proviz
type: application
version: v0.0.1
dependencies:
-   name: es-proviz
    repository: https://datatok.github.io/helm-charts/
    version: 0.0.3
```

## Troubleshoot
