# This file handles the AVM common interfaces (locks, role assignments, diagnostic settings)
# using the avm-utl-interfaces utility module v1.0 prep branch
# 
# NOTE: Using feat/prepv1 branch to test the new drift-free diagnostic settings implementation
# See: https://github.com/Azure/terraform-azure-avm-utl-interfaces/pull/29

module "avm_interfaces" {
  source = "git::https://github.com/Azure/terraform-azure-avm-utl-interfaces.git?ref=feat/prepv1"

  diagnostic_settings  = var.diagnostic_settings
  enable_telemetry     = var.enable_telemetry
  lock                 = var.lock
  parent_id            = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  role_assignments     = var.role_assignments
  this_resource_id     = azapi_resource.this_environment.id
}

# Note: The feat/prepv1 branch creates all resources internally
# No need for manual azapi_resource blocks for lock, role_assignments, or diagnostic_settings
