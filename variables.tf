variable "istio_version" {
  description = "tetrate istio distribution version"
  type        = string
}

variable "istio_helm_namespace" {
  description = "tetrate istio distribution helm namespace"
  type        = string
  default     = "istio-system"
}

variable "istio_operator_helm_namespace" {
  description = "tetrate istio distribution operator helm namespace"
  type        = string
  default     = "istio-operator"
}

variable "istio_helm_repo" {
  description = "tetrate istio distribution helm repository"
  type        = string
  default     = "https://tetratelabs.github.io/helm-charts"
}


variable "istio_base_settings" {
  description = "istio base settings"
  type        = map(any)
  default     = {}
}

variable "istio_base_enabled" {
  description = "enable helm install of istio base"
  type        = bool
  default     = true
}

variable "istio_cni_settings" {
  description = "istio cni settings"
  type        = map(any)
  default     = {}
}

variable "istio_cni_enabled" {
  description = "enable helm install of istio cni"
  type        = bool
  default     = false
}

variable "istio_istiod_settings" {
  description = "istio istiod settings"
  type        = map(any)
  default     = {}
}

variable "istio_istiod_enabled" {
  description = "enable helm install of istio istiod"
  type        = bool
  default     = true
}

variable "istio_gateway_settings" {
  description = "istio gateway settings"
  type        = map(any)
  default     = {}
}

variable "istio_gateway_enabled" {
  description = "enable helm install of istio gateway"
  type        = bool
  default     = true
}

variable "istio_ingress_gateway_settings" {
  description = "istio ingress gateway settings"
  type        = map(any)
  default     = {}
}

variable "istio_ingress_gateway_enabled" {
  description = "enable helm install of istio ingress gateway"
  type        = bool
  default     = false
}

variable "istio_egress_gateway_settings" {
  description = "istio egress gateway settings"
  type        = map(any)
  default     = {}
}

variable "istio_egress_gateway_enabled" {
  description = "enable helm install of istio egress gateway"
  type        = bool
  default     = false
}

variable "istio_istiod_remote_settings" {
  description = "istio istiod-remote settings"
  type        = map(any)
  default     = {}
}

variable "istio_istiod_remote_enabled" {
  description = "enable helm install of istio istiod-remote"
  type        = bool
  default     = false
}

variable "istio_istio_operator_settings" {
  description = "istio istio-operator settings"
  type        = map(any)
  default     = {}
}

variable "istio_istiod_operator_enabled" {
  description = "enable helm install of istio istio-operator"
  type        = bool
  default     = false
}
