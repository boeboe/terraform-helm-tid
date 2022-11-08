output "istio_base_helm_metadata" {
  description = "block status of the istio base helm release"
  value       = length(helm_release.base) > 0 ? helm_release.base[0].metadata : null
}

output "istio_cni_helm_metadata" {
  description = "block status of the istio cni helm release"
  value       = length(helm_release.cni) > 0 ? helm_release.cni[0].metadata : null
}

output "istio_istiod_helm_metadata" {
  description = "block status of the istio istiod helm release"
  value       = length(helm_release.istiod) > 0 ? helm_release.istiod[0].metadata : null
}

output "istio_gateway_helm_metadata" {
  description = "block status of the istio gateway helm release"
  value       = length(helm_release.gateway) > 0 ? helm_release.gateway[0].metadata : null
}

output "istio_ingress_gateway_helm_metadata" {
  description = "block status of the istio ingress gateway helm release"
  value       = length(helm_release.ingress_gateway) > 0 ? helm_release.ingress_gateway[0].metadata : null
}

output "istio_egress_gateway_helm_metadata" {
  description = "block status of the istio egress gateway helm release"
  value       = length(helm_release.egress_gateway) > 0 ? helm_release.egress_gateway[0].metadata : null
}

output "istio_istiod_remote_helm_metadata" {
  description = "block status of the istio istiod-remote helm release"
  value       = length(helm_release.istiod_remote) > 0 ? helm_release.istiod_remote[0].metadata : null
}

output "istio_istio_operator_helm_metadata" {
  description = "block status of the istio istio-operator helm release"
  value       = length(helm_release.istio_operator) > 0 ? helm_release.istio_operator[0].metadata : null
}
