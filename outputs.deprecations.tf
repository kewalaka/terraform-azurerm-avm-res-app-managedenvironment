# Output deprecations
#
# `deprecation_warnings` emits a list of human-readable strings — one per deprecated
# input variable that is currently set. When no deprecated variables are in use the
# output value is an empty list.
#
# This is the pre-1.15 substitute for the native `deprecated` attribute on input
# variables (https://github.com/hashicorp/terraform/issues/42119). Once >= 1.15 is
# the minimum required Terraform version, replace this output with `deprecated = "..."`
# on each variable declaration in deprecations.tf and delete this file.
#
# NOTE: Ephemeral deprecated variables (custom_domain_certificate_password,
# dapr_application_insights_connection_string, log_analytics_workspace_primary_shared_key)
# cannot be included here — ephemeral values may not flow into non-ephemeral outputs.

output "deprecation_warnings" {
  description = "Deprecation warnings for any deprecated input variables that are currently set. Empty when no deprecated variables are in use. Check blocks in deprecations.tf also emit these as plan/apply warnings."
  value = compact([
    var.zone_redundancy_enabled != null ? "DEPRECATED: 'zone_redundancy_enabled' has been renamed to 'zone_redundant'. Please update your configuration." : null,
    var.infrastructure_resource_group_name != null ? "DEPRECATED: 'infrastructure_resource_group_name' has been renamed to 'infrastructure_resource_group'. Please update your configuration." : null,
    var.public_network_access_enabled != null ? "DEPRECATED: 'public_network_access_enabled' (bool) has been replaced by 'public_network_access' (string: \"Enabled\" or \"Disabled\"). Please update your configuration." : null,
    var.workload_profile != null ? "DEPRECATED: 'workload_profile' (set) has been renamed to 'workload_profiles' (list). Please update your configuration." : null,
    var.internal_load_balancer_enabled != null ? "DEPRECATED: 'internal_load_balancer_enabled' has been replaced by 'vnet_configuration = { internal = true }'. Please update your configuration." : null,
    var.infrastructure_subnet_id != null ? "DEPRECATED: 'infrastructure_subnet_id' has been replaced by 'vnet_configuration = { infrastructure_subnet_id = \"...\" }'. Please update your configuration." : null,
    var.peer_authentication_enabled != null ? "DEPRECATED: 'peer_authentication_enabled' has been replaced by 'peer_authentication = { mtls = { enabled = true } }'. Please update your configuration." : null,
    var.peer_traffic_encryption_enabled != null ? "DEPRECATED: 'peer_traffic_encryption_enabled' has been replaced by 'peer_traffic_configuration = { encryption = { enabled = true } }'. Please update your configuration." : null,
    var.custom_domain_dns_suffix != null ? "DEPRECATED: 'custom_domain_dns_suffix' has been replaced by 'custom_domain_configuration = { dns_suffix = \"...\" }'. Please update your configuration." : null,
    var.custom_domain_certificate_key_vault_url != null ? "DEPRECATED: 'custom_domain_certificate_key_vault_url' has been replaced by 'custom_domain_configuration.certificate_key_vault_properties.key_vault_url'. Please update your configuration." : null,
    var.custom_domain_certificate_key_vault_identity != null ? "DEPRECATED: 'custom_domain_certificate_key_vault_identity' has been replaced by 'custom_domain_configuration.certificate_key_vault_properties.identity'. Please update your configuration." : null,
    var.custom_domain_certificate_value != null ? "DEPRECATED: 'custom_domain_certificate_value' has been replaced by 'custom_domain_configuration.certificate_value'. Please update your configuration." : null,
    var.log_analytics_workspace_customer_id != null ? "DEPRECATED: 'log_analytics_workspace_customer_id' has been replaced by 'app_logs_configuration.log_analytics_configuration.customer_id' (or use 'log_analytics_workspace.resource_id' to auto-fetch). Please update your configuration." : null,
    var.log_analytics_workspace_destination != null ? "DEPRECATED: 'log_analytics_workspace_destination' has been replaced by 'app_logs_configuration.destination'. Please update your configuration." : null,
  ])
}
