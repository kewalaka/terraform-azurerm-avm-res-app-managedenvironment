# Deprecated input variables — backward-compatibility shims for the azurerm-style API.
#
# Each variable is nullable (default = null), so omitting it has no effect.
# When set, it acts as a fallback for the new variable name; the new variable takes priority.
#
# Check blocks emit WARNING messages (not errors) when a deprecated variable is supplied.
# They do not prevent plan/apply from succeeding — they are informational only.
#
# Note: Terraform 1.15 will introduce a native `deprecated` attribute on input variables
# (https://github.com/hashicorp/terraform/issues/42119). Once that ships, these variables
# should be migrated to use the built-in mechanism and this file can be simplified.
#
# Ephemeral deprecated variables (custom_domain_certificate_password,
# dapr_application_insights_connection_string, log_analytics_workspace_primary_shared_key)
# cannot use check blocks because ephemeral values are not permitted in check conditions.
# They are wired in via locals.tf without a runtime warning.

# ── Simple renames ──────────────────────────────────────────────────────────────

variable "zone_redundancy_enabled" {
  description = "DEPRECATED: Renamed to `zone_redundant`. Will be removed in a future major release."
  type        = bool
  default     = null
}

variable "infrastructure_resource_group_name" {
  description = "DEPRECATED: Renamed to `infrastructure_resource_group`. Will be removed in a future major release."
  type        = string
  default     = null
}

# ── Type changes ────────────────────────────────────────────────────────────────

variable "public_network_access_enabled" {
  description = "DEPRECATED: Use `public_network_access` (string: `\"Enabled\"` or `\"Disabled\"`) instead. Will be removed in a future major release."
  type        = bool
  default     = null
}

variable "workload_profile" {
  description = "DEPRECATED: Renamed to `workload_profiles` (list). Will be removed in a future major release."
  type = set(object({
    maximum_count         = optional(number)
    minimum_count         = optional(number)
    name                  = string
    workload_profile_type = string
  }))
  default = null
}

# ── Flat → nested migrations ─────────────────────────────────────────────────

variable "internal_load_balancer_enabled" {
  description = "DEPRECATED: Use `vnet_configuration = { internal = true }` instead. Will be removed in a future major release."
  type        = bool
  default     = null
}

variable "infrastructure_subnet_id" {
  description = "DEPRECATED: Use `vnet_configuration = { infrastructure_subnet_id = \"...\" }` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

variable "peer_authentication_enabled" {
  description = "DEPRECATED: Use `peer_authentication = { mtls = { enabled = true } }` instead. Will be removed in a future major release."
  type        = bool
  default     = null
}

variable "peer_traffic_encryption_enabled" {
  description = "DEPRECATED: Use `peer_traffic_configuration = { encryption = { enabled = true } }` instead. Will be removed in a future major release."
  type        = bool
  default     = null
}

variable "custom_domain_dns_suffix" {
  description = "DEPRECATED: Use `custom_domain_configuration = { dns_suffix = \"...\" }` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

variable "custom_domain_certificate_key_vault_url" {
  description = "DEPRECATED: Use `custom_domain_configuration.certificate_key_vault_properties.key_vault_url` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

variable "custom_domain_certificate_key_vault_identity" {
  description = "DEPRECATED: Use `custom_domain_configuration.certificate_key_vault_properties.identity` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

variable "custom_domain_certificate_value" {
  description = "DEPRECATED: Use `custom_domain_configuration.certificate_value` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

# ── Log analytics ───────────────────────────────────────────────────────────────

variable "log_analytics_workspace_customer_id" {
  description = "DEPRECATED: Use `app_logs_configuration.log_analytics_configuration.customer_id`, or set `log_analytics_workspace.resource_id` to auto-fetch. Will be removed in a future major release."
  type        = string
  default     = null
}

variable "log_analytics_workspace_destination" {
  description = "DEPRECATED: Use `app_logs_configuration.destination` instead. Will be removed in a future major release."
  type        = string
  default     = null
}

# ── Ephemeral deprecated variables ─────────────────────────────────────────────
# Check blocks cannot reference ephemeral values. These fall back silently.

variable "custom_domain_certificate_password" {
  description = "DEPRECATED: Use `certificate_password` (ephemeral) + `certificate_password_version` instead. Will be removed in a future major release."
  ephemeral   = true
  type        = string
  default     = null
}

variable "dapr_application_insights_connection_string" {
  description = "DEPRECATED: Use `dapr_ai_connection_string` (ephemeral) + `dapr_ai_connection_string_version` instead. Will be removed in a future major release."
  ephemeral   = true
  type        = string
  default     = null
}

variable "log_analytics_workspace_primary_shared_key" {
  description = "DEPRECATED: Use `shared_key` (ephemeral) + `shared_key_version` instead. Will be removed in a future major release."
  ephemeral   = true
  type        = string
  default     = null
}

# ── Check blocks (non-ephemeral deprecated variables only) ──────────────────────

check "deprecated_zone_redundancy_enabled" {
  assert {
    condition     = var.zone_redundancy_enabled == null
    error_message = "Variable `zone_redundancy_enabled` is deprecated. Rename to `zone_redundant`."
  }
}

check "deprecated_infrastructure_resource_group_name" {
  assert {
    condition     = var.infrastructure_resource_group_name == null
    error_message = "Variable `infrastructure_resource_group_name` is deprecated. Rename to `infrastructure_resource_group`."
  }
}

check "deprecated_public_network_access_enabled" {
  assert {
    condition     = var.public_network_access_enabled == null
    error_message = "Variable `public_network_access_enabled` is deprecated. Use `public_network_access` (\"Enabled\" or \"Disabled\") instead."
  }
}

check "deprecated_workload_profile" {
  assert {
    condition     = var.workload_profile == null
    error_message = "Variable `workload_profile` (set) is deprecated. Rename to `workload_profiles` (list)."
  }
}

check "deprecated_internal_load_balancer_enabled" {
  assert {
    condition     = var.internal_load_balancer_enabled == null
    error_message = "Variable `internal_load_balancer_enabled` is deprecated. Use `vnet_configuration = { internal = true }` instead."
  }
}

check "deprecated_infrastructure_subnet_id" {
  assert {
    condition     = var.infrastructure_subnet_id == null
    error_message = "Variable `infrastructure_subnet_id` is deprecated. Use `vnet_configuration = { infrastructure_subnet_id = \"...\" }` instead."
  }
}

check "deprecated_peer_authentication_enabled" {
  assert {
    condition     = var.peer_authentication_enabled == null
    error_message = "Variable `peer_authentication_enabled` is deprecated. Use `peer_authentication = { mtls = { enabled = true } }` instead."
  }
}

check "deprecated_peer_traffic_encryption_enabled" {
  assert {
    condition     = var.peer_traffic_encryption_enabled == null
    error_message = "Variable `peer_traffic_encryption_enabled` is deprecated. Use `peer_traffic_configuration = { encryption = { enabled = true } }` instead."
  }
}

check "deprecated_custom_domain_dns_suffix" {
  assert {
    condition     = var.custom_domain_dns_suffix == null
    error_message = "Variable `custom_domain_dns_suffix` is deprecated. Use `custom_domain_configuration = { dns_suffix = \"...\" }` instead."
  }
}

check "deprecated_custom_domain_certificate_key_vault_url" {
  assert {
    condition     = var.custom_domain_certificate_key_vault_url == null
    error_message = "Variable `custom_domain_certificate_key_vault_url` is deprecated. Use `custom_domain_configuration.certificate_key_vault_properties.key_vault_url` instead."
  }
}

check "deprecated_custom_domain_certificate_key_vault_identity" {
  assert {
    condition     = var.custom_domain_certificate_key_vault_identity == null
    error_message = "Variable `custom_domain_certificate_key_vault_identity` is deprecated. Use `custom_domain_configuration.certificate_key_vault_properties.identity` instead."
  }
}

check "deprecated_custom_domain_certificate_value" {
  assert {
    condition     = var.custom_domain_certificate_value == null
    error_message = "Variable `custom_domain_certificate_value` is deprecated. Use `custom_domain_configuration.certificate_value` instead."
  }
}

check "deprecated_log_analytics_workspace_customer_id" {
  assert {
    condition     = var.log_analytics_workspace_customer_id == null
    error_message = "Variable `log_analytics_workspace_customer_id` is deprecated. Use `app_logs_configuration.log_analytics_configuration.customer_id`, or set `log_analytics_workspace.resource_id` to auto-fetch."
  }
}

check "deprecated_log_analytics_workspace_destination" {
  assert {
    condition     = var.log_analytics_workspace_destination == null
    error_message = "Variable `log_analytics_workspace_destination` is deprecated. Use `app_logs_configuration.destination` instead."
  }
}
