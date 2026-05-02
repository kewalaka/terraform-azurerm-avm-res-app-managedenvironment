# Upgrade Guide

This document describes breaking changes when upgrading this module between versions.

---

## 0.4.0 to 0.5.0 (Unreleased)

### Variable Renames

The following root-module variables have been renamed or restructured:

| Old Variable | New Variable / Location | Notes |
|---|---|---|
| `zone_redundancy_enabled` | `zone_redundant` | Boolean, same semantics |
| `workload_profile` (set) | `workload_profiles` (list) | Same shape, now a list instead of set |
| `peer_authentication_enabled` (bool) | `peer_authentication` (object) | `peer_authentication = { mtls = { enabled = true } }` |
| `peer_traffic_encryption_enabled` (bool) | `peer_traffic_configuration` (object) | `peer_traffic_configuration = { encryption = { enabled = true } }` |
| `public_network_access_enabled` (bool) | `public_network_access` (string) | `"Enabled"` or `"Disabled"` |
| `internal_load_balancer_enabled` (bool) | `vnet_configuration.internal` (bool) | Set inside `vnet_configuration` object |
| `infrastructure_subnet_id` (string) | `vnet_configuration.infrastructure_subnet_id` (string) | Set inside `vnet_configuration` object |
| `infrastructure_resource_group_name` | `infrastructure_resource_group` | Renamed |
| `custom_domain_certificate_password` | `certificate_password` (ephemeral) + `certificate_password_version` | Now ephemeral; version tracker required |
| `custom_domain_dns_suffix` | `custom_domain_configuration.dns_suffix` | Moved into `custom_domain_configuration` object |
| `custom_domain_certificate_key_vault_url` | `custom_domain_configuration.certificate_key_vault_properties.key_vault_url` | Moved into nested object |
| `custom_domain_certificate_key_vault_identity` | `custom_domain_configuration.certificate_key_vault_properties.identity` | Moved into nested object |
| `custom_domain_certificate_value` | `custom_domain_configuration.certificate_value` | Moved into `custom_domain_configuration` object |
| `dapr_application_insights_connection_string` | `dapr_ai_connection_string` (ephemeral) + `dapr_ai_connection_string_version` | Now ephemeral; version tracker required |
| `log_analytics_workspace_customer_id` | `app_logs_configuration.log_analytics_configuration.customer_id` | Moved into `app_logs_configuration` object |
| `log_analytics_workspace_destination` | `app_logs_configuration.destination` | Moved into `app_logs_configuration` object |
| `log_analytics_workspace_primary_shared_key` | `shared_key` (ephemeral) + `shared_key_version` | Now ephemeral; version tracker required |

### Breaking Schema Changes

#### `storages`

The `storages` variable schema has changed from a flat structure to a nested one matching the azapi resource body:

**Before:**

```hcl
storages = {
  "my-storage" = {
    access_key   = "..."
    access_mode  = "ReadWrite"
    account_name = "mystorageaccount"
    share_name   = "myshare"
  }
}
```

**After:**

```hcl
storages = {
  "my-storage" = {
    name     = "my-storage"
    azure_file = {
      access_mode  = "ReadWrite"
      account_name = "mystorageaccount"
      share_name   = "myshare"
    }
    account_key         = "..."  # ephemeral
    account_key_version = 1
  }
}
```

#### `dapr_components`

The `version` key has been renamed to `dapr_components_version`. The `secret` block (singular, set) has been replaced by `secrets` (list).

**Before:**

```hcl
dapr_components = {
  "my-component" = {
    component_type = "state.redis"
    version        = "v1"
    secret = [{
      name  = "redis-password"
      value = "..."
    }]
  }
}
```

**After:**

```hcl
dapr_components = {
  "my-component" = {
    name                    = "my-component"
    component_type          = "state.redis"
    dapr_components_version = "v1"
    secrets = [{
      name  = "redis-password"
      value = "..."
    }]
    secrets_version = 1
  }
}
```

#### `certificates`

The `certificates` variable has been restructured to support the azapi resource body pattern with ephemeral `password` and `value` fields:

**Before (via `var.certificates` inline schema):**

```hcl
certificates = {
  "my-cert" = {
    certificate_password              = "..."
    certificate_value                 = "..."
    subject_name                      = "..."
    ...
  }
}
```

**After:**

```hcl
certificates = {
  "my-cert" = {
    name             = "my-cert"
    location         = "eastus"
    password         = "..."   # ephemeral
    password_version = 1
    value            = "..."   # ephemeral (base64 PFX/PEM)
    value_version    = 1
    certificate_key_vault_properties = {   # optional
      identity      = "..."
      key_vault_url = "..."
    }
  }
}
```

#### `managed_certificates`

**Before:**

```hcl
managed_certificates = {
  "my-cert" = {
    subject_name              = "..."
    domain_control_validation = "HTTP"
  }
}
```

**After:**

```hcl
managed_certificates = {
  "my-cert" = {
    name                      = "my-cert"
    location                  = "eastus"
    subject_name              = "..."
    domain_control_validation = "HTTP"
  }
}
```

### Ephemeral Variables and Version Trackers

Several variables are now marked as `ephemeral = true`, meaning their values are not stored in Terraform state. Each ephemeral variable requires a corresponding `_version` variable that must be incremented when the secret value changes (to trigger re-application).

| Ephemeral Variable | Version Tracker |
|---|---|
| `shared_key` | `shared_key_version` |
| `certificate_password` | `certificate_password_version` |
| `dapr_ai_connection_string` | `dapr_ai_connection_string_version` |
| `dapr_ai_instrumentation_key` | `dapr_ai_instrumentation_key_version` |

### Log Analytics Backward Compatibility

The `log_analytics_workspace` variable (resource ID-based) is preserved for backward compatibility. It continues to auto-fetch the primary shared key and customer ID.

The following variables are removed; use `app_logs_configuration` instead:

- `log_analytics_workspace_customer_id` → `app_logs_configuration.log_analytics_configuration.customer_id`
- `log_analytics_workspace_destination` → `app_logs_configuration.destination`
- `log_analytics_workspace_primary_shared_key` → `shared_key` (ephemeral)

### Provider Version Changes

| Provider | Before | After |
|---|---|---|
| `azapi` | `~> 2.6` | `~> 2.7` |

### API Version Change

The main resource API version has been upgraded from `2025-02-02-preview` to `2025-07-01` (GA).

---
