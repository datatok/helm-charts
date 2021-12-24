# zeppelin

![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.10.0](https://img.shields.io/badge/AppVersion-0.10.0-informational?style=flat-square)

Apache Zeppelin with Apache Spark

**Homepage:** <https://github.com/ebuildy/helm-data-lake>

## Examples

* Deploy with Spark fully embedded (driver+worker): [examples/zep+spark-embedded](../../examples/zep+spark-embedded)

## Spark deploy architectures

Spark have 3 components:
* driver = the java zeppelin interpreter application
* master (aka cluster manager)
* worker = where the code is executed

![spark cluster components](/docs/spark-cluster.png)

More details at https://spark.apache.org/docs/latest/cluster-overview.html.

All components can run in the same java process / container or can run separately.

There are severals ways to run Spark:

** run driver within zeppelin container ** (stable)

Aka `local` mode, the easiest way to run Spark, no network-policy between zeppelin and spark interpreter.

![zeppelin spark embedded](/docs/zep-1.png)

** run executor within zeppelin container ** (stable)

If driver is running within zeppelin container, use `local` executor (aka master = local[X]) in order to run everything in the same java process.
Here , executor = driver (= zeppelin interpreter java application), be sure to give enough memory for zeppelin + spark.

![zeppelin spark embedded](/docs/zep-1.png)

** run driver in a separate container ** (beta)

K8S zeppelin mode is broken (https://github.com/apache/zeppelin/pull/4192).
As a workaround, we can deploy the zep'spark interpreter with the Helm chart [charts/zeppelin-int](../zeppelin-int).

![zeppelin spark separately](/docs/zep-2.png)

** run executors within an external Spark cluster ** (beta)

With `spark-master` and `spark-worker` Helm chart, you can deploy a Spark cluster.
Setting master = spark://my-spark-master:7077 will run executor(s) in this cluster.

![zeppelin spark separately](/docs/zep-3.png)

** run executors using K8S master ** (not tested)

Spark provide natif K8S support https://spark.apache.org/docs/latest/running-on-kubernetes.html

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Thomas Decaux | ebuildy@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"apache/zeppelin"` |  |
| image.tag | string | `"0.9.0"` |  |
| imagePullSecrets | list | `[]` | To use private images |
| ingress.annotations | object | `{}` | Annotations to use cert-manager and sticky sessions |
| ingress.enabled | bool | `false` | Enable Zeppelin server ingress |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| logging.level | string | `"INFO"` |  |
| logging.syslog | object | `{}` |  |
| nameOverride | string | `""` |  |
| networkPolicy.enabled | bool | `false` | enable network policy |
| networkPolicy.extraEgressRules | list | `[]` | add extra NP egress rules |
| networkPolicy.extraIngressRules | list | `[]` | add extra NP ingress rules |
| nodeSelector | object | `{}` |  |
| notebookStorage.repositorySecret | string | `"git-data-lake"` | if type is `git` , use this secret to get the repository URL (usually the URL contains an access token) |
| notebookStorage.type | string | `"git"` | Kind of storage for notebook |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` | see https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| replicaCount | int | `1` | Pod replica count |
| resources | object | `{}` | Resources, dont be greedy for memory, this is java :-)  |
| securityContext | object | `{}` | see https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| service.port | int | `8080` | HTTP server port |
| service.rpcPort | int | `38853` | RPC port, to register interpreter |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `"default"` |  |
| serviceAccount.rbac.create | bool | `false` |  |
| spark.config | object | `{}` | Spark configuration |
| spark.dependencies | object | `{}` | download dependencies via an init container to use proxy only for this |
| spark.driver.ingress | object | `{"enabled":false}` | if mode is `local`, create an ingress to access to Spark UI |
| spark.driver.mode | string | `"local"` | driver mode, `local` will run Zeppelin Spark interpreter in the same container, `external` will connect to an interpreter running in another pod |
| spark.driver.uiPort | int | `4040` | if mode is `local`, Spark UI port, usually 4040 |
| spark.executor.cores | string | `"*"` | how many cores (* to use all CPUs) -- in `local` mode, this is equivalent to master = local[cores] |
| spark.executor.count | int | `2` | if mode is not local, how many executors to deploy |
| spark.executor.deployMode | string | `"client"` | if mode is not local, deploy mode (client / cluster) |
| spark.executor.masterURL | string | `""` | if mode is not local, full master URL |
| spark.executor.mode | string | `"local"` | `local` will run executor in the same driver java process / cluster / k8s |
| spark.homeArtifacts.copyDirectory | string | `"/opt/bitnami/spark"` |  |
| spark.homeArtifacts.image.pullPolicy | string | `"IfNotPresent"` |  |
| spark.homeArtifacts.image.registry | string | `"docker.io"` |  |
| spark.homeArtifacts.image.repository | string | `"bitnami/spark"` |  |
| spark.homeArtifacts.image.tag | string | `"2.4.5"` |  |
| tolerations | list | `[]` |  |
| zeppelin.config."zeppelin.interpreter.output.limit" | int | `102400` | Output message from interpreter exceeding the limit will be truncated |
| zeppelin.config."zeppelin.notebook.dir" | string | `"notebook"` | notebooks storage dir |
| zeppelin.config."zeppelin.notebook.homescreen" | string | `""` | id of notebook to be displayed in homescreen. ex) 2A94M5J1Z Empty value displays default home screen |
| zeppelin.config."zeppelin.notebook.homescreen.hide" | bool | `false` | hide homescreen notebook from list when this value set to true |
| zeppelin.config."zeppelin.server.addr" | string | `"0.0.0.0"` | IP to listen to (usually `0.0.0.0`) |
| zeppelin.config."zeppelin.server.context.path" | string | `"/"` | Context Path of the Web Application (usually `/`) |
| zeppelin.interpreter.enabled | bool | `true` |  |
| zeppelin.interpreter.thriftPort | int | `10000` |  |
| zeppelin.server.jvmMemOptions | string | `"-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -Xms512m -Xmx512m -XX:MaxMetaspaceSize=512m"` | Zeppelin Java process memory options |