# spark

![Version: 5.7.1](https://img.shields.io/badge/Version-5.7.1-informational?style=flat-square) ![AppVersion: 2.4.5](https://img.shields.io/badge/AppVersion-2.4.5-informational?style=flat-square)

Spark is a fast and general-purpose cluster computing system.

**Homepage:** <https://github.com/bitnami/charts/tree/master/bitnami/spark>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Bitnami | containers@bitnami.com |  |

## Source Code

* <https://github.com/bitnami/bitnami-docker-spark>
* <https://spark.apache.org/>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 1.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| diagnosticMode.args[0] | string | `"infinity"` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.enabled | bool | `false` |  |
| extraDeploy | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.imageRegistry | string | `""` |  |
| hostNetwork | bool | `false` |  |
| image.debug | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"bitnami/spark"` |  |
| image.tag | string | `"2.4.5"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.apiVersion | string | `""` |  |
| ingress.certManager | bool | `false` |  |
| ingress.enabled | bool | `false` |  |
| ingress.extraHosts | list | `[]` |  |
| ingress.extraPaths | list | `[]` |  |
| ingress.extraTls | list | `[]` |  |
| ingress.hostname | string | `"spark.local"` |  |
| ingress.path | string | `"/"` |  |
| ingress.pathType | string | `"ImplementationSpecific"` |  |
| ingress.secrets | list | `[]` |  |
| ingress.tls | bool | `false` |  |
| kubeVersion | string | `""` |  |
| master.affinity | object | `{}` |  |
| master.clusterPort | int | `7077` |  |
| master.configOptions | string | `""` |  |
| master.configurationConfigMap | string | `""` |  |
| master.daemonMemoryLimit | string | `""` |  |
| master.extraEnvVars | list | `[]` |  |
| master.extraPodLabels | object | `{}` |  |
| master.hostAliases | list | `[]` |  |
| master.initContainers | list | `[]` |  |
| master.livenessProbe.enabled | bool | `true` |  |
| master.livenessProbe.failureThreshold | int | `6` |  |
| master.livenessProbe.initialDelaySeconds | int | `180` |  |
| master.livenessProbe.periodSeconds | int | `20` |  |
| master.livenessProbe.successThreshold | int | `1` |  |
| master.livenessProbe.timeoutSeconds | int | `5` |  |
| master.nodeAffinityPreset.key | string | `""` |  |
| master.nodeAffinityPreset.type | string | `""` |  |
| master.nodeAffinityPreset.values | list | `[]` |  |
| master.nodeSelector | object | `{}` |  |
| master.podAffinityPreset | string | `""` |  |
| master.podAnnotations | object | `{}` |  |
| master.podAntiAffinityPreset | string | `"soft"` |  |
| master.readinessProbe.enabled | bool | `true` |  |
| master.readinessProbe.failureThreshold | int | `6` |  |
| master.readinessProbe.initialDelaySeconds | int | `30` |  |
| master.readinessProbe.periodSeconds | int | `10` |  |
| master.readinessProbe.successThreshold | int | `1` |  |
| master.readinessProbe.timeoutSeconds | int | `5` |  |
| master.resources.limits.cpu | string | `"250m"` |  |
| master.resources.limits.memory | string | `"600Mi"` |  |
| master.resources.requests.cpu | string | `"50m"` |  |
| master.resources.requests.memory | string | `"512Mi"` |  |
| master.securityContext.enabled | bool | `true` |  |
| master.securityContext.fsGroup | int | `1001` |  |
| master.securityContext.runAsGroup | int | `0` |  |
| master.securityContext.runAsUser | int | `1001` |  |
| master.securityContext.seLinuxOptions | object | `{}` |  |
| master.tolerations | list | `[]` |  |
| master.webPort | int | `8080` |  |
| metrics.enabled | bool | `false` |  |
| metrics.masterAnnotations."prometheus.io/path" | string | `"/metrics/"` |  |
| metrics.masterAnnotations."prometheus.io/port" | string | `"{{ .Values.master.webPort }}"` |  |
| metrics.masterAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| metrics.podMonitor.additionalLabels | object | `{}` |  |
| metrics.podMonitor.enabled | bool | `false` |  |
| metrics.podMonitor.extraMetricsEndpoints | list | `[]` |  |
| metrics.podMonitor.interval | string | `"30s"` |  |
| metrics.podMonitor.namespace | string | `""` |  |
| metrics.podMonitor.scrapeTimeout | string | `""` |  |
| metrics.prometheusRule.additionalLabels | object | `{}` |  |
| metrics.prometheusRule.enabled | bool | `false` |  |
| metrics.prometheusRule.namespace | string | `""` |  |
| metrics.prometheusRule.rules | list | `[]` |  |
| metrics.workerAnnotations."prometheus.io/path" | string | `"/metrics/"` |  |
| metrics.workerAnnotations."prometheus.io/port" | string | `"{{ .Values.worker.webPort }}"` |  |
| metrics.workerAnnotations."prometheus.io/scrape" | string | `"true"` |  |
| nameOverride | string | `""` |  |
| networkPolicy.enabled | bool | `true` |  |
| podSecurityContext.fsGroup | int | `1000` |  |
| security.certificatesSecretName | string | `""` |  |
| security.passwordsSecretName | string | `""` |  |
| security.rpc.authenticationEnabled | bool | `false` |  |
| security.rpc.encryptionEnabled | bool | `false` |  |
| security.ssl.autoGenerated | bool | `false` |  |
| security.ssl.enabled | bool | `false` |  |
| security.ssl.existingSecret | string | `""` |  |
| security.ssl.keystorePassword | string | `""` |  |
| security.ssl.needClientAuth | bool | `false` |  |
| security.ssl.protocol | string | `"TLSv1.2"` |  |
| security.ssl.resources.limits | object | `{}` |  |
| security.ssl.resources.requests | object | `{}` |  |
| security.ssl.truststorePassword | string | `""` |  |
| security.storageEncryptionEnabled | bool | `false` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `1001` |  |
| service.annotations | object | `{}` |  |
| service.clusterPort | int | `7077` |  |
| service.loadBalancerIP | string | `""` |  |
| service.nodePorts.cluster | string | `""` |  |
| service.nodePorts.web | string | `""` |  |
| service.type | string | `"ClusterIP"` |  |
| service.webPort | int | `80` |  |
| service.worker.loadBalancerIP | string | `""` |  |
| service.worker.nodePorts.cluster | string | `""` |  |
| service.worker.nodePorts.web | string | `""` |  |
| worker.affinity | object | `{}` |  |
| worker.autoscaling.CpuTargetPercentage | int | `50` |  |
| worker.autoscaling.enabled | bool | `false` |  |
| worker.autoscaling.replicasMax | int | `5` |  |
| worker.clusterPort | string | `""` |  |
| worker.configOptions | string | `""` |  |
| worker.configurationConfigMap | string | `""` |  |
| worker.coreLimit | string | `""` |  |
| worker.daemonMemoryLimit | string | `""` |  |
| worker.dir | string | `""` |  |
| worker.extraEnvVars | list | `[]` |  |
| worker.extraPodLabels | object | `{}` |  |
| worker.extraPorts | list | `[]` |  |
| worker.hostAliases | list | `[]` |  |
| worker.initContainers | list | `[]` |  |
| worker.javaOptions | string | `""` |  |
| worker.livenessProbe.enabled | bool | `true` |  |
| worker.livenessProbe.failureThreshold | int | `6` |  |
| worker.livenessProbe.initialDelaySeconds | int | `180` |  |
| worker.livenessProbe.periodSeconds | int | `20` |  |
| worker.livenessProbe.successThreshold | int | `1` |  |
| worker.livenessProbe.timeoutSeconds | int | `5` |  |
| worker.memoryLimit | string | `""` |  |
| worker.nodeAffinityPreset.key | string | `""` |  |
| worker.nodeAffinityPreset.type | string | `""` |  |
| worker.nodeAffinityPreset.values | list | `[]` |  |
| worker.nodeSelector | object | `{}` |  |
| worker.podAffinityPreset | string | `""` |  |
| worker.podAnnotations | object | `{}` |  |
| worker.podAntiAffinityPreset | string | `"soft"` |  |
| worker.podManagementPolicy | string | `"OrderedReady"` |  |
| worker.readinessProbe.enabled | bool | `true` |  |
| worker.readinessProbe.failureThreshold | int | `6` |  |
| worker.readinessProbe.initialDelaySeconds | int | `30` |  |
| worker.readinessProbe.periodSeconds | int | `10` |  |
| worker.readinessProbe.successThreshold | int | `1` |  |
| worker.readinessProbe.timeoutSeconds | int | `5` |  |
| worker.replicaCount | int | `2` |  |
| worker.resources.limits.cpu | string | `"250m"` |  |
| worker.resources.limits.memory | string | `"1200Mi"` |  |
| worker.resources.requests.cpu | string | `"50m"` |  |
| worker.resources.requests.memory | string | `"1024Mi"` |  |
| worker.securityContext.enabled | bool | `true` |  |
| worker.securityContext.fsGroup | int | `1001` |  |
| worker.securityContext.runAsGroup | int | `0` |  |
| worker.securityContext.runAsUser | int | `1001` |  |
| worker.securityContext.seLinuxOptions | object | `{}` |  |
| worker.tolerations | list | `[]` |  |
| worker.webPort | int | `8081` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
