locals {
  istio_version                 = var.istio_version
  istio_helm_namespace          = var.istio_helm_namespace
  istio_operator_helm_namespace = var.istio_operator_helm_namespace
  istio_helm_repo               = var.istio_helm_repo

  istio_base_enabled            = var.istio_base_enabled
  istio_cni_enabled             = var.istio_cni_enabled
  istio_istiod_enabled          = var.istio_istiod_enabled
  istio_gateway_enabled         = var.istio_gateway_enabled
  istio_ingress_gateway_enabled = var.istio_ingress_gateway_enabled
  istio_egress_gateway_enabled  = var.istio_egress_gateway_enabled
  istio_istiod_remote_enabled   = var.istio_istiod_remote_enabled
  istio_istio_operator_enabled  = var.istio_istio_operator_enabled

  istio_base_settings            = var.istio_base_settings
  istio_cni_settings             = var.istio_cni_settings
  istio_istiod_settings          = var.istio_istiod_settings
  istio_gateway_settings         = var.istio_gateway_settings
  istio_ingress_gateway_settings = var.istio_ingress_gateway_settings
  istio_egress_gateway_settings  = var.istio_egress_gateway_settings
  istio_istiod_remote_settings   = var.istio_istiod_remote_settings
  istio_istio_operator_settings  = var.istio_istio_operator_settings
}

resource "helm_release" "base" {
  count = local.istio_base_enabled ? 1 : 0

  name             = "istio-base"
  repository       = local.istio_helm_repo
  chart            = "base"
  version          = local.istio_version
  create_namespace = true
  namespace        = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_base_settings
    content {
      name  = set.key
      value = set.value
    }
  }
}

resource "helm_release" "cni" {
  count = local.istio_cni_enabled ? 1 : 0

  name       = "istio-cni"
  repository = local.istio_helm_repo
  chart      = "cni"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_cni_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base
  ]
}

resource "helm_release" "istiod" {
  count = local.istio_istiod_enabled ? 1 : 0

  name       = "istio-istiod"
  repository = local.istio_helm_repo
  chart      = "istiod"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_istiod_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base
  ]
}

resource "helm_release" "gateway" {
  count = local.istio_gateway_enabled ? 1 : 0

  name       = "istio-gateway"
  repository = local.istio_helm_repo
  chart      = "gateway"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_gateway_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base,
    helm_release.istiod
  ]
}

resource "helm_release" "ingress_gateway" {
  count = local.istio_ingress_gateway_enabled ? 1 : 0

  name       = "istio-ingress"
  repository = local.istio_helm_repo
  chart      = "istio-ingress"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_ingress_gateway_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base,
    helm_release.istiod
  ]
}

resource "helm_release" "egress_gateway" {
  count = local.istio_egress_gateway_enabled ? 1 : 0

  name       = "istio-egress"
  repository = local.istio_helm_repo
  chart      = "istio-egress"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_egress_gateway_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base,
    helm_release.istiod
  ]
}

resource "helm_release" "istiod_remote" {
  count = local.istio_istiod_remote_enabled ? 1 : 0

  name       = "istiod-remote"
  repository = local.istio_helm_repo
  chart      = "istiod-remote"
  version    = local.istio_version
  namespace  = local.istio_helm_namespace

  dynamic "set" {
    for_each = local.istio_istiod_remote_settings
    content {
      name  = set.key
      value = set.value
    }
  }

  depends_on = [
    helm_release.base,
    helm_release.istiod
  ]
}

resource "helm_release" "istio_operator" {
  count = local.istio_istio_operator_enabled ? 1 : 0

  name             = "istio-operator"
  repository       = local.istio_helm_repo
  chart            = "istio-operator"
  version          = local.istio_version
  create_namespace = true
  namespace        = local.istio_operator_helm_namespace

  dynamic "set" {
    for_each = local.istio_istio_operator_settings
    content {
      name  = set.key
      value = set.value
    }
  }
}
