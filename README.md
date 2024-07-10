<!--- app-name: Opensearch Dashboards -->

# Opensearch Dashboards

Opensearch Dashboards is an open source, browser based analytics and search for Opensearch. Opensearch Dashboards strives to be easy to get started with, while also being flexible and powerful.

[Overview of Dashboards](https://opensearch.org/docs/latest/dashboards/index/)
                           
## TL;DR

```console
$ helm install my-release oci://registry-1.docker.io/captnbp/opensearch-dashboards
```

## Introduction

This chart bootstraps a Opensearch Dashboards deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.26+
- Helm 3.10.0+

## Installing the Chart

This chart requires an Opensearch instance to work. You can use an already existing Opensearch instance.

 To install the chart with the release name `my-release`:

```console
$ helm install my-release oci://registry-1.docker.io/captnbp/opensearch-dashboards
```

These commands deploy Opensearch Dashboards on the Kubernetes cluster in the default configuration. The [Parameters](#parameters) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` statefulset:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release. Use the option `--purge` to delete all history too.

## Parameters

### Global parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `global.imageRegistry`    | Global Docker image registry                    | `""`  |
| `global.imagePullSecrets` | Global Docker registry secret names as an array | `[]`  |

### Common parameters

| Name                     | Description                                                                                               | Value           |
| ------------------------ | --------------------------------------------------------------------------------------------------------- | --------------- |
| `kubeVersion`            | Force target Kubernetes version (using Helm capabilities if not set)                                      | `""`            |
| `nameOverride`           | String to partially override common.names.fullname template with a string (will prepend the release name) | `""`            |
| `fullnameOverride`       | String to fully override common.names.fullname template with a string                                     | `""`            |
| `commonAnnotations`      | Annotations to add to all deployed objects                                                                | `{}`            |
| `commonLabels`           | Labels to add to all deployed objects                                                                     | `{}`            |
| `extraDeploy`            | A list of extra kubernetes resources to be deployed                                                       | `[]`            |
| `clusterDomain`          | Kubernetes cluster domain name                                                                            | `cluster.local` |
| `diagnosticMode.enabled` | Enable diagnostic mode (all probes will be disabled and the command will be overridden)                   | `false`         |
| `diagnosticMode.command` | Command to override all containers in the the deployment(s)/statefulset(s)                                | `["sleep"]`     |
| `diagnosticMode.args`    | Args to override all containers in the the deployment(s)/statefulset(s)                                   | `["infinity"]`  |

### Opensearch Dashboards deployment parameters

| Name                                                | Description                                                                                                                                                             | Value                                     |
| --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| `image.registry`                                    | Dashboard image registry                                                                                                                                                | `docker.io`                               |
| `image.repository`                                  | Dashboard image repository                                                                                                                                              | `opensearchproject/opensearch-dashboards` |
| `image.tag`                                         | Dashboard image tag (immutable tags are recommended)                                                                                                                    | `2.15.0`                                  |
| `image.pullPolicy`                                  | Dashboard image pull policy                                                                                                                                             | `IfNotPresent`                            |
| `image.pullSecrets`                                 | Specify docker-registry secret names as an array                                                                                                                        | `[]`                                      |
| `replicaCount`                                      | Number of replicas of the Opensearch Dashboards Pod                                                                                                                     | `1`                                       |
| `updateStrategy.type`                               | Set up update strategy for Opensearch Dashboards installation.                                                                                                          | `RollingUpdate`                           |
| `schedulerName`                                     | Alternative scheduler                                                                                                                                                   | `""`                                      |
| `priorityClassName`                                 | opensearch-dashboards pods' priorityClassName                                                                                                                           | `""`                                      |
| `terminationGracePeriodSeconds`                     | In seconds, time the given to the opensearch-dashboards pod needs to terminate gracefully                                                                               | `""`                                      |
| `topologySpreadConstraints`                         | Topology Spread Constraints for pod assignment                                                                                                                          | `[]`                                      |
| `hostAliases`                                       | Add deployment host aliases                                                                                                                                             | `[]`                                      |
| `plugins`                                           | Array containing the Opensearch Dashboards plugins to be installed in deployment                                                                                        | `[]`                                      |
| `extraConfiguration`                                | Extra settings to be added to the default opensearch_dashboards.yml configmap that the chart creates (unless replaced using `configurationCM`). Evaluated as a template | `{}`                                      |
| `configurationCM`                                   | ConfigMap containing a opensearch_dashboards.yml file that will replace the default one specified in configuration.yaml                                                 | `""`                                      |
| `command`                                           | Override default container command (useful when using custom images)                                                                                                    | `[]`                                      |
| `args`                                              | Override default container args (useful when using custom images)                                                                                                       | `[]`                                      |
| `lifecycleHooks`                                    | for the opensearch-dashboards container(s) to automate configuration before or after startup                                                                            | `{}`                                      |
| `extraEnvVars`                                      | Array containing extra env vars to configure Opensearch Dashboards                                                                                                      | `[]`                                      |
| `extraEnvVarsCM`                                    | ConfigMap containing extra env vars to configure Opensearch Dashboards                                                                                                  | `""`                                      |
| `extraEnvVarsSecret`                                | Secret containing extra env vars to configure Opensearch Dashboards (in case of sensitive data)                                                                         | `""`                                      |
| `extraVolumes`                                      | Array to add extra volumes. Requires setting `extraVolumeMounts`                                                                                                        | `[]`                                      |
| `extraVolumeMounts`                                 | Array to add extra mounts. Normally used with `extraVolumes`                                                                                                            | `[]`                                      |
| `livenessProbe.enabled`                             | Enable/disable the Liveness probe                                                                                                                                       | `true`                                    |
| `livenessProbe.initialDelaySeconds`                 | Delay before liveness probe is initiated                                                                                                                                | `120`                                     |
| `livenessProbe.periodSeconds`                       | How often to perform the probe                                                                                                                                          | `10`                                      |
| `livenessProbe.timeoutSeconds`                      | When the probe times out                                                                                                                                                | `5`                                       |
| `livenessProbe.failureThreshold`                    | Minimum consecutive failures for the probe to be considered failed after having succeeded.                                                                              | `6`                                       |
| `livenessProbe.successThreshold`                    | Minimum consecutive successes for the probe to be considered successful after having failed.                                                                            | `1`                                       |
| `readinessProbe.enabled`                            | Enable/disable the Readiness probe                                                                                                                                      | `true`                                    |
| `readinessProbe.initialDelaySeconds`                | Delay before readiness probe is initiated                                                                                                                               | `30`                                      |
| `readinessProbe.periodSeconds`                      | How often to perform the probe                                                                                                                                          | `10`                                      |
| `readinessProbe.timeoutSeconds`                     | When the probe times out                                                                                                                                                | `5`                                       |
| `readinessProbe.failureThreshold`                   | Minimum consecutive failures for the probe to be considered failed after having succeeded.                                                                              | `6`                                       |
| `readinessProbe.successThreshold`                   | Minimum consecutive successes for the probe to be considered successful after having failed.                                                                            | `1`                                       |
| `containerPorts.http`                               | Port to expose at container level                                                                                                                                       | `5601`                                    |
| `podSecurityContext.enabled`                        | Enabled opensearch-dashboards pods' Security Context                                                                                                                    | `true`                                    |
| `podSecurityContext.fsGroup`                        | Set opensearch-dashboards pod's Security Context fsGroup                                                                                                                | `1000`                                    |
| `containerSecurityContext.enabled`                  | Enabled opensearch-dashboards containers' Security Context                                                                                                              | `true`                                    |
| `containerSecurityContext.runAsUser`                | Set opensearch-dashboards containers' Security Context runAsUser                                                                                                        | `1000`                                    |
| `containerSecurityContext.runAsNonRoot`             | Set opensearch-dashboards container's Security Context runAsNonRoot                                                                                                     | `true`                                    |
| `containerSecurityContext.allowPrivilegeEscalation` | Controls whether a process can gain more privileges than its parent process                                                                                             | `false`                                   |
| `resources.limits`                                  | The resources limits for the container                                                                                                                                  | `{}`                                      |
| `resources.requests`                                | The requested resources for the container                                                                                                                               | `{}`                                      |
| `podAffinityPreset`                                 | Pod affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                     | `""`                                      |
| `podAntiAffinityPreset`                             | Pod anti-affinity preset. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                                | `soft`                                    |
| `nodeAffinityPreset.type`                           | Node affinity preset type. Ignored if `affinity` is set. Allowed values: `soft` or `hard`                                                                               | `""`                                      |
| `nodeAffinityPreset.key`                            | Node label key to match Ignored if `affinity` is set.                                                                                                                   | `""`                                      |
| `nodeAffinityPreset.values`                         | Node label values to match. Ignored if `affinity` is set.                                                                                                               | `[]`                                      |
| `affinity`                                          | Affinity for pod assignment                                                                                                                                             | `{}`                                      |
| `nodeSelector`                                      | Node labels for pod assignment                                                                                                                                          | `{}`                                      |
| `tolerations`                                       | Tolerations for pod assignment                                                                                                                                          | `[]`                                      |
| `podAnnotations`                                    | Pod annotations                                                                                                                                                         | `{}`                                      |
| `podLabels`                                         | Extra labels to add to Pod                                                                                                                                              | `{}`                                      |
| `sidecars`                                          | Attach additional containers to the pod                                                                                                                                 | `[]`                                      |
| `initContainers`                                    | Add additional init containers to the pod                                                                                                                               | `[]`                                      |
| `deploymentAnnotations`                             | Annotations for deployment                                                                                                                                              | `{}`                                      |
| `configuration`                                     | Opensearch Dashboards configuration                                                                                                                                     | `{}`                                      |

### Opensearch Dashboards openid configuration

| Name                   | Description                                     | Value                                                                                  |
| ---------------------- | ----------------------------------------------- | -------------------------------------------------------------------------------------- |
| `openid.enabled`       | Enable openid authentication                    | `false`                                                                                |
| `openid.connect_url`   | The IdP metadata endpoint                       | `https://keycloak.example.com:443/auth/realms/master/.well-known/openid-configuration` |
| `openid.client_id`     | The ID of the OpenID Connect client in your IdP | `""`                                                                                   |
| `openid.client_secret` | The client secret of the OpenID Connect client  | `""`                                                                                   |
| `openid.scope`         | OIDC scopes                                     | `openid profile email`                                                                 |

### Opensearch Dashboards server TLS configuration

| Name                               | Description                                                                                                                                                                                                                                                                                                                                                                          | Value             |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ----------------- |
| `tls.enabled`                      | Enable SSL/TLS encryption for Opensearch Dashboards server (HTTPS)                                                                                                                                                                                                                                                                                                                   | `true`            |
| `tls.existingSecret`               | Name of the existing secret containing Opensearch Dashboards server certificates                                                                                                                                                                                                                                                                                                     | `""`              |
| `tls.algorithm`                    | Algorithm of the private key. Allowed values are either RSA,Ed25519 or ECDSA.                                                                                                                                                                                                                                                                                                        | `RSA`             |
| `tls.size`                         | Size is the key bit size of the corresponding private key for this certificate. If algorithm is set to RSA, valid values are 2048, 4096 or 8192, and will default to 2048 if not specified. If algorithm is set to ECDSA, valid values are 256, 384 or 521, and will default to 256 if not specified. If algorithm is set to Ed25519, Size is ignored. No other values are allowed.  | `2048`            |
| `tls.issuerRef.existingIssuerName` | Existing name of the cert-manager http issuer. If provided, it won't create a default one.                                                                                                                                                                                                                                                                                           | `""`              |
| `tls.issuerRef.kind`               | Kind of the cert-manager issuer resource (defaults to "Issuer")                                                                                                                                                                                                                                                                                                                      | `Issuer`          |
| `tls.issuerRef.group`              | Group of the cert-manager issuer resource (defaults to "cert-manager.io")                                                                                                                                                                                                                                                                                                            | `cert-manager.io` |
| `tls.extraCACerts`                 | Add extra pem CA certs for Dashboards                                                                                                                                                                                                                                                                                                                                                | `""`              |

### Opensearch parameters

| Name                                          | Description                                                                                             | Value        |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------ |
| `opensearch.hosts`                            | List of opensearch hosts to connect to.                                                                 | `[]`         |
| `opensearch.port`                             | Opensearch port                                                                                         | `""`         |
| `opensearch.security.auth.enabled`            | Set to 'true' if Opensearch has authentication enabled                                                  | `false`      |
| `opensearch.security.auth.dashboardsUsername` | Dashboard server user to authenticate with Opensearch                                                   | `dashboards` |
| `opensearch.security.auth.dashboardsPassword` | Dashboard server password to authenticate with Opensearch                                               | `""`         |
| `opensearch.security.auth.existingSecret`     | Name of the existing secret containing the Password for the Dashboard user                              | `""`         |
| `opensearch.security.tls.enabled`             | Set to 'true' if Opensearch API uses TLS/SSL (HTTPS)                                                    | `false`      |
| `opensearch.security.tls.verificationMode`    | Verification mode for SSL communications.                                                               | `full`       |
| `opensearch.security.tls.existingSecret`      | Name of the existing secret containing Opensearch CA certificate. Required unless verificationMode=none | `""`         |

### Exposure parameters

| Name                               | Description                                                                                                                      | Value                         |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ----------------------------- |
| `service.ports.http`               | Kubernetes Service port                                                                                                          | `5601`                        |
| `service.type`                     | Kubernetes Service type                                                                                                          | `ClusterIP`                   |
| `service.nodePorts.http`           | Specify the nodePort value for the LoadBalancer and NodePort service types                                                       | `""`                          |
| `service.clusterIP`                | opensearch-dashboards service Cluster IP                                                                                         | `""`                          |
| `service.loadBalancerIP`           | loadBalancerIP if Opensearch Dashboards service type is `LoadBalancer`                                                           | `""`                          |
| `service.loadBalancerSourceRanges` | opensearch-dashboards service Load Balancer sources                                                                              | `[]`                          |
| `service.externalTrafficPolicy`    | Enable client source IP preservation                                                                                             | `Cluster`                     |
| `service.annotations`              | Annotations for Opensearch Dashboards service (evaluated as a template)                                                          | `{}`                          |
| `service.labels`                   | Extra labels for Opensearch Dashboards service                                                                                   | `{}`                          |
| `service.extraPorts`               | Extra ports to expose in the service (normally used with the `sidecar` value)                                                    | `[]`                          |
| `service.sessionAffinity`          | Session Affinity for Kubernetes service, can be "None" or "ClientIP"                                                             | `None`                        |
| `service.sessionAffinityConfig`    | Additional settings for the sessionAffinity                                                                                      | `{}`                          |
| `service.ipFamilyPolicy`           | ipFamilyPolicy for dashboards service                                                                                            | `PreferDualStack`             |
| `ingress.enabled`                  | Enable ingress controller resource                                                                                               | `true`                        |
| `ingress.pathType`                 | Ingress Path type                                                                                                                | `ImplementationSpecific`      |
| `ingress.apiVersion`               | Override API Version (automatically detected if not set)                                                                         | `""`                          |
| `ingress.hostname`                 | Default host for the ingress resource. If specified as "*" no host rule is configured                                            | `opensearch-dashboards.local` |
| `ingress.path`                     | The Path to Opensearch Dashboards. You may need to set this to '/*' in order to use this with ALB ingress controllers.           | `/`                           |
| `ingress.annotations`              | Additional annotations for the Ingress resource. To enable certificate autogeneration, place here your cert-manager annotations. | `{}`                          |
| `ingress.tls`                      | Enable TLS configuration for the hostname defined at ingress.hostname parameter                                                  | `true`                        |
| `ingress.selfSigned`               | Create a TLS secret for this ingress record using self-signed certificates generated by Helm                                     | `false`                       |
| `ingress.extraHosts`               | The list of additional hostnames to be covered with this ingress record.                                                         | `[]`                          |
| `ingress.extraPaths`               | Additional arbitrary path/backend objects                                                                                        | `[]`                          |
| `ingress.extraTls`                 | The tls configuration for additional hostnames to be covered with this ingress record.                                           | `[]`                          |
| `ingress.secrets`                  | If you're providing your own certificates, please use this to add the certificates as secrets                                    | `[]`                          |
| `ingress.ingressClassName`         | IngressClass that will be be used to implement the Ingress (Kubernetes 1.18+)                                                    | `""`                          |
| `ingress.ingressControllerType`    | ingressControllerType that will be be used to implement the Ingress specific annotations (Ex. nginx or traefik)                  | `nginx`                       |
| `ingress.extraRules`               | The list of additional rules to be added to this ingress record. Evaluated as a template                                         | `[]`                          |

### RBAC parameters

| Name                                          | Description                                                                                                         | Value   |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------- |
| `serviceAccount.create`                       | Specifies whether a ServiceAccount should be created                                                                | `true`  |
| `serviceAccount.name`                         | Name of the service account to use. If not set and create is true, a name is generated using the fullname template. | `""`    |
| `serviceAccount.automountServiceAccountToken` | Automount service account token for the server service account                                                      | `false` |
| `serviceAccount.annotations`                  | Annotations for service account. Evaluated as a template. Only used if `create` is `true`.                          | `{}`    |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install my-release \
  --set admin.user=admin-user doca/opensearch-dashboards
```

The above command sets the Opensearch Dashboards admin user to `admin-user`.

> NOTE: Once this chart is deployed, it is not possible to change the application's access credentials, such as usernames or passwords, using Helm. To change these application credentials after deployment, delete any persistent volumes (PVs) used by the chart and re-deploy it, or use the application's built-in administrative tools if available.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install my-release -f values.yaml doca/opensearch-dashboards
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Configuration and installation details

### [Rolling vs Immutable tags](https://docs.bitnami.com/containers/how-to/understand-rolling-tags-containers/)

It is strongly recommended to use immutable tags in a production environment. This ensures your deployment does not change automatically if the same tag is updated with a different image.

### Use custom configuration

The Opensearch Dashboards chart supports using custom configuration settings. For example, to mount a custom `opensearch_dashboards.yml` you can create a ConfigMap like the following:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: myconfig
data:
  opensearch_dashboards.yml: |-
    # Raw text of the file
```

And now you need to pass the ConfigMap name, to the corresponding parameter: `configurationCM=myconfig`

An alternative is to provide extra configuration settings to the default kibana.yml that the chart deploys. This is done using the `extraConfiguration` value:

```yaml
extraConfiguration:
  "server.maxPayloadBytes": 1048576
  "server.pingTimeout": 1500
```

### Add extra environment variables

In case you want to add extra environment variables (useful for advanced operations like custom init scripts), you can use the `extraEnvVars` property.

```yaml
extraEnvVars:
  - name: OPENSEARCH_VERSION
    value: 2
```

Alternatively, you can use a ConfigMap or a Secret with the environment variables. To do so, use the `extraEnvVarsCM` or the `extraEnvVarsSecret` values.

### Use Sidecars and Init Containers

If additional containers are needed in the same pod (such as additional metrics or logging exporters), they can be defined using the `sidecars` config parameter. Similarly, extra init containers can be added using the `initContainers` parameter.

Refer to the chart documentation for more information on, and examples of, configuring and using [sidecars and init containers](https://docs.bitnami.com/kubernetes/apps/kibana/configuration/configure-sidecar-init-containers/).

### Set Pod affinity

This chart allows you to set custom Pod affinity using the `affinity` parameter. Find more information about Pod affinity in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity).

As an alternative, you can use one of the preset configurations for pod affinity, pod anti-affinity, and node affinity available at the [bitnami/common](https://github.com/bitnami/charts/tree/master/bitnami/common#affinities) chart. To do so, set the `podAffinityPreset`, `podAntiAffinityPreset`, or `nodeAffinityPreset` parameters.

### Add extra volumes

The Opensearch Dashboards chart supports mounting extra volumes (either PVCs, secrets or configmaps) by using the `extraVolumes` and `extraVolumeMounts` property. This can be combined with advanced operations like adding extra init containers and sidecars.

## Troubleshooting

Find more information about how to deal with common errors related to Bitnami's Helm charts in [this troubleshooting guide](https://docs.bitnami.com/general/how-to/troubleshoot-helm-chart-issues).

## Upgrading

## License

MIT License

Copyright (c) 2024 Benoît Pourre

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
