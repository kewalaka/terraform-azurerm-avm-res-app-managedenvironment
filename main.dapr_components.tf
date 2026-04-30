module "dapr_components" {
  source                  = "./modules/dapr_components"
  for_each                = var.dapr_components
  component_type          = each.value.component_type
  dapr_components_version = each.value.dapr_components_version
  enable_telemetry        = each.value.enable_telemetry
  ignore_errors           = each.value.ignore_errors
  init_timeout            = each.value.init_timeout
  location                = each.value.location
  metadata                = each.value.metadata
  name                    = each.value.name
  parent_id               = azapi_resource.this_environment.id
  scopes                  = each.value.scopes
  secret_store_component  = each.value.secret_store_component
  secrets                 = each.value.secrets
  secrets_version         = each.value.secrets_version
}
