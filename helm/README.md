# NBA ELT REST API Helm Chart

This Helm chart deploys the NBA ELT REST API application to a Kubernetes cluster.

- `examples/` contains read-only rendered K8s Manifest Files for both dev & prod
- `manual/` contains K8s Manifest Files created manually in July 2024
- `templates/` contains the actual Helm templates that render into K8s Manifests
- `Chart.yaml` contains chart metadata about the chart name, version, appVersion, maintainer etc
- `values-dev.yaml` contains the config settings for deploying the chart to a dev environment (lower resources, no autoscaling, debug on etc)
- `values-prod.yaml` contains the config settings for deploying the chart to a prod environment (more resources, autoscaling etc)

## Manual Commands

```bash
# lint chart for Helm-specific problems. it uses the default `values.yaml`
helm lint .

# lint also with dev and prod values.yaml files
helm lint . --values values-dev.yaml
helm lint . --values values-prod.yaml

# render templates locally to inspect or save them
helm template nba-elt-rest-api-dev --namespace dev . --values values-dev.yaml > examples/rendered-dev.yaml

helm template nba-elt-rest-api-prod --namespace prod . --values values-prod.yaml > examples/rendered-prod.yaml
```

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-nba-api`:

```bash
helm install my-nba-api ./helm/nba-elt-rest-api
```

## Installing with custom values

For development:
```bash
helm install my-nba-api ./helm/nba-elt-rest-api -f ./helm/nba-elt-rest-api/values-dev.yaml
```

For production:
```bash
helm install my-nba-api ./helm/nba-elt-rest-api -f ./helm/nba-elt-rest-api/values-prod.yaml
```

## Configuration

The following table lists the configurable parameters of the NBA ELT REST API chart and their default values.

### Application Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `replicaCount` | Number of replicas | `3` |
| `image.repository` | Image repository | `nba_elt_rest_api_local` |
| `image.pullPolicy` | Image pull policy | `Never` |
| `image.tag` | Image tag | `latest` |

### Service Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `service.type` | Service type | `LoadBalancer` |
| `service.port` | Service port | `8080` |
| `service.targetPort` | Target port | `8080` |

### Autoscaling Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `autoscaling.enabled` | Enable autoscaling | `true` |
| `autoscaling.minReplicas` | Minimum replicas | `1` |
| `autoscaling.maxReplicas` | Maximum replicas | `5` |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization | `70` |

### Resource Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `resources.limits.cpu` | CPU limit | `2000m` |
| `resources.limits.memory` | Memory limit | `4Gi` |
| `resources.requests.cpu` | CPU request | `1000m` |
| `resources.requests.memory` | Memory request | `2Gi` |

### Secret Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `secrets.apiKey` | API Key | `""` |
| `secrets.envType` | Environment type | `""` |
| `secrets.rdsHost` | RDS host | `""` |
| `secrets.rdsUser` | RDS user | `""` |
| `secrets.rdsPassword` | RDS password | `""` |
| `secrets.rdsDb` | RDS database | `""` |
| `secrets.rdsSchema` | RDS schema | `""` |
| `secrets.redisUrl` | Redis URL | `""` |

## Uninstalling the Chart

To uninstall/delete the `my-nba-api` deployment:

```bash
helm delete my-nba-api
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Examples

### Setting secrets via command line:

```bash
helm install my-nba-api ./helm/nba-elt-rest-api \
  --set-string secrets.apiKey="your-api-key" \
  --set-string secrets.rdsHost="your-rds-host" \
  --set-string secrets.rdsPassword="your-password"
```

### Using a secrets file:

```bash
helm install my-nba-api ./helm/nba-elt-rest-api \
  -f ./helm/nba-elt-rest-api/values-prod.yaml \
  -f ./path/to/your/secrets.yaml
```
