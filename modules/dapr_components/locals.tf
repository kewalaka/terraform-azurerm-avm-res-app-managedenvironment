locals {
  resource_body = {
    name = var.name
    properties = {
      componentType = var.component_type
      ignoreErrors  = var.ignore_errors
      initTimeout   = var.init_timeout
      metadata = var.metadata == null ? null : [for item in var.metadata : item == null ? null : {
        name      = item.name
        secretRef = item.secret_ref
        value     = item.value
      }]
      scopes               = var.scopes == null ? null : [for item in var.scopes : item]
      secretStoreComponent = var.secret_store_component
      version              = var.dapr_components_version
    }
  }
}
