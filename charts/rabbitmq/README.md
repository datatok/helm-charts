# rabbitmq

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.9.5-management](https://img.shields.io/badge/AppVersion-3.9.5--management-informational?style=flat-square)

Deploy rabbitMQ with official K8S operators

## Features

This Helm chart allow to deploy:

* RabbitMQ cluster via the operator
* RabbitMQ resources (queue, user, exchanges, ...) via the operator
* K8S Ingress to the management web UI
* right networkPolicy

## Requirements

**you need official operator from RabbitMQ:**

* RabbitMQ cluster operator: https://www.rabbitmq.com/kubernetes/operator/install-operator.html
* RabbitMQ messaging topology operator: https://www.rabbitmq.com/kubernetes/operator/install-topology-operator.html

(extra networkPolicy can be needed)

## Examples

* Deploy with users defined as secrets: [examples/rabbitmq+secret](examples/rabbitmq+secret)
* Deploy under polaris constraints [examples/rabbitmq+polaris](examples/rabbitmq+polaris)

## Immutability

Lot of CRD fields are immutable , this will give error like:

```
Error: UPGRADE FAILED: cannot patch "XXX" with kind Binding: admission webhook "vbinding.kb.io" denied the request: Binding.rabbitmq.com "XXX" is invalid: spec.source: Invalid value: "logstash": source cannot be updated
```

To fix it, you can manually remove the CRD (<!> this will remove RabbitMQ object as well <!>).
Or just change CRD name, Helm will automatically remove the CRD and deploy the new one.

## Documentation

Most of ``values.yaml`` fields are applied "as is" to RabbitMQ CRD resources,
so you can follow RabbitMQ documentation at https://www.rabbitmq.com/kubernetes/operator/operator-overview.html.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cluster.annotations | object | `{}` | cluster CRD annotations |
| cluster.extraSpec | object | `{}` | cluster CRD extra spec |
| cluster.override | object | `{}` | cluster CRD spec.override |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"rabbitmq"` |  |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.podSelector | object | `{}` |  |
| ingress.tls | list | `[]` |  |
| nameOverride | string | `""` |  |
| networkPolicy.clientPodSelector | object | `{}` | specify AMQP port selector (full open else) |
| networkPolicy.enabled | bool | `false` | enable network policy |
| networkPolicy.extraEgressRules | list | `[]` | add extra NP egress rules |
| networkPolicy.extraIngressRules | list | `[]` | add extra NP ingress rules |
| operator.namespace | string | `"rabbitmq-system"` | namespace where is the operator (used by network-policy) |
| persistence.enabled | bool | `false` |  |
| persistence.storage | string | `"20Gi"` |  |
| persistence.storageClassName | string | `"fast"` |  |
| rabbitmq.additionalConfig | string | `""` |  |
| rabbitmq.additionalPlugins | object | `{}` |  |
| rabbitmq.advancedConfig | string | `""` |  |
| rabbitmq.bindings | string | `nil` | Define bindings (name only for K8S object) |
| rabbitmq.exchanges | string | `nil` | Define exchanges (name is the real exchange name) |
| rabbitmq.permissions | string | `nil` | Define permissions (name only for K8S object) |
| rabbitmq.queues | string | `nil` | Define queues (name is the real queue name) |
| rabbitmq.users | string | `nil` | Define users (name only for K8S object) |
| rabbitmq.vhosts[0] | string | `"test"` |  |
| replicaCount | int | `3` |  |
| resources | string | `nil` |  |
| service.annotations | object | `{}` |  |
| service.type | string | `"ClusterIP"` |  |
