# terraform-helm-tid

![Terraform Version](https://img.shields.io/badge/terraform-≥_1.0.0-blueviolet)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/boeboe/terraform-helm-tid?label=registry)](https://registry.terraform.io/modules/boeboe/tid/helm)
[![GitHub issues](https://img.shields.io/github/issues/boeboe/terraform-helm-tid)](https://github.com/boeboe/terraform-helm-tid/issues)
[![Open Source Helpers](https://www.codetriage.com/boeboe/terraform-helm-tid/badges/users.svg)](https://www.codetriage.com/boeboe/terraform-helm-tid)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

This terraform module will deploy [tetrate istio distribution](https://istio.tetratelabs.io) on any kubernetes cluster, using the tetrate istio distribution [helm charts](https://github.com/tetratelabs/helm-charts).

| Helm Chart | Repo | Default Values |
|------------|------|--------|
| base | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/base) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/base/values.yaml) |
| cni | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-cni) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-cni/values.yaml) |
| istiod | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-control/istio-discovery) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-control/istio-discovery/values.yaml) |
| gateway | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateway) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateway/values.yaml) |
| istio-ingress | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateways/istio-ingress) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateways/istio-ingress/values.yaml) |
| istio-egress | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateways/istio-egress) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/gateways/istio-egress/values.yaml) |
| istiod-remote | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istiod-remote) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istiod-remote/values.yaml) |
| istio-operator | [repo](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-operator) | [values](https://github.com/tetratelabs/helm-charts/tree/main/charts/istio-1.14.4/istio-operator/values.yaml) |

> **WARNING** the `istio-ingress` and `istio-egress` charts are being replaced by the `gateway` chart. You can still use the old charts, but follow up on migration, differences and benefits in the following [notes](https://github.com/istio/istio/tree/master/manifests/charts/gateway#legacy-gateway-helm-charts).


## Usage

``` hcl
provider "kubernetes" {
  config_path    = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
  }
}

module "tid" {
  source  = "boeboe/tid/helm"
  version = "0.0.1"

  istio_version = "1.14.4"

  istio_istiod_settings = {
    "pilot.autoscaleMin" = 2
    "pilot.autoscaleMax" = 4
  }
  
  istio_gateway_settings = {
    "autoscaling.minReplicas" = 2
    "autoscaling.maxReplicas" = 4
  }
}

output "istio_istiod_helm_metadata" {
  description = "block status of the istio istiod helm release"
  value = module.tid.istio_istiod_helm_metadata[0]
}
```

Check the [examples](examples) for more details.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| istio_version | tetrate istio distribution version | string | - | true |
| istio_helm_namespace | tetrate istio distribution helm namespace | string | "istio-system" | false |
| istio_operator_helm_namespace | tetrate istio distribution operator helm namespace | string | "istio-operator" | false |
| istio_helm_repo | tetrate istio distribution helm repository | string | "https://tetratelabs.github.io/helm-charts" | false |
| istio_base_settings | istio base settings | map | {} | false |
| istio_base_enabled | enable helm install of istio base | bool | true | false |
| istio_cni_settings | istio cni settings | map | {} | false |
| istio_cni_enabled | enable helm install of istio cni | bool | false | false |
| istio_istiod_settings | istio istiod settings | map | {} | false |
| istio_istiod_enabled | enable helm install of istio istiod | bool | true | false |
| istio_gateway_settings | istio gateway settings | map | {} | false |
| istio_gateway_enabled | enable helm install of istio gateway | bool | true | false |
| istio_ingress_gateway_settings | istio ingress gateway settings | map | {} | false |
| istio_ingress_gateway_enabled | enable helm install of istio ingress gateway | bool | false | false |
| istio_egress_gateway_settings | istio egress gateway settings | map | {} | false |
| istio_egress_gateway_enabled | enable helm install of istio egress gateway | bool | false | false |
| istio_istiod_remote_settings | istio istiod-remote settings | map | {} | false |
| istio_istiod_remote_enabled | enable helm install of istio istiod remote | bool | false | false |
| istio_istio_operator_settings | istio istio-operator settings | map | {} | false |
| istio_istio_operator_enabled | enable helm install of istio-operator | bool | false | false |

## Outputs

| Name | Description | Type |
|------|-------------|------|
| istio_base_helm_metadata | block status of the istio base helm release | list |
| istio_cni_helm_metadata | block status of the istio cni helm release | list |
| istio_istiod_helm_metadata | block status of the istio istiod helm release | list |
| istio_gateway_helm_metadata | block status of the istio gateway helm release | list |
| istio_ingress_gateway_helm_metadata | block status of the istio ingress gateway helm release | list |
| istio_egress_gateway_helm_metadata | block status of the istio egress gateway helm release | list |
| istio_istiod_remote_helm_metadata | block status of the istio istiod-remote helm release | list |
| istio_istio_operator_helm_metadata | block status of the istio istio-operator helm release | list |


Example output:

``` hcl
istio_istiod_helm_metadata = {
  "app_version" = "1.14.4-tetrate-multiarch-v1"
  "chart" = "istiod"
  "name" = "istio-istiod"
  "namespace" = "istio-system"
  "revision" = 1
  "values" = "{\"pilot\":{\"autoscaleMax\":4,\"autoscaleMin\":2}}"
  "version" = "1.14.4"
}
```

## Versions

Available container image versions, to be set with the `global.tag` helm setting per chart:

| global.tag |
|------------|
| 1.14.4-tetratefips-v0 |
| 1.14.4-tetratefips-v0-debug |
| 1.14.4-tetratefips-v0-distroless |
| **1.14.4-tetrate-multiarch-v1** (default) |
| 1.14.4-tetrate-multiarch-v1-debug |
| 1.14.4-tetrate-multiarch-v1-distroless |
| 1.14.4-tetrate-multiarch-v1-amd64 |
| 1.14.4-tetrate-multiarch-v1-amd64-debug |
| 1.14.4-tetrate-multiarch-v1-amd64-distroless |
| 1.14.4-tetrate-multiarch-v1-arm64 |
| 1.14.4-tetrate-multiarch-v1-arm64-debug |
| 1.14.4-tetrate-multiarch-v1-arm64-distroless |
| 1.14.4-tetrate-v0 |
| 1.14.4-tetrate-v0-debug |
| 1.14.4-tetrate-v0-distroless |

## License

terraform-helm-tid is released under the **MIT License**. See the bundled [LICENSE](LICENSE) file for details.
