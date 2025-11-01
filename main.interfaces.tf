# This file handles the AVM common interfaces (locks, role assignments, diagnostic settings)
# using the avm-utl-interfaces utility module v1.0 prep branch
#
# NOTE: Using feat/prepv1 branch from kewalaka fork to test the bug fix before PR
# Original issue: missing 'type' field in role_assignments locals
# Fork: https://github.com/kewalaka/terraform-azure-avm-utl-interfaces-1/tree/feat/prepv1

module "avm_interfaces" {
  source = "git::https://github.com/kewalaka/terraform-azure-avm-utl-interfaces-1.git?ref=feat/prepv1"

  diagnostic_settings  = var.diagnostic_settings
  enable_telemetry     = var.enable_telemetry
  lock                 = var.lock
  parent_id            = "/subscriptions/${data.azapi_client_config.current.subscription_id}"
  role_assignments     = var.role_assignments
  this_resource_id     = azapi_resource.this_environment.id
}

# Note: The feat/prepv1 branch creates all resources internally
# No need for manual azapi_resource blocks for lock, role_assignments, or diagnostic_settings
