# Upgrade Guide

This document describes breaking changes when upgrading this module from the `azurerm`-style API to the `azapi`-native API.

---

## Variable Renames

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

---

## Submodule Renames

All child resource submodules have been renamed from singular to plural, and updated to use `azapi`:

| Old Module Path | New Module Path |
|---|---|
| `modules/certificate` | `modules/certificates` |
| `modules/dapr_component` | `modules/dapr_components` |
| `modules/managed_certificate` | `modules/managed_certificates` |
| `modules/storage` | `modules/storages` |

---

## New Submodules

The following child resource submodules are now available:

| Module | API Version | Notes |
|---|---|---|
| `modules/dapr_subscriptions` | `2025-10-02-preview` | Preview API |
| `modules/maintenance_configurations` | `2025-07-01` | |
| `modules/dot_net_components` | `2025-10-02-preview` | Preview API |
| `modules/java_components` | `2025-07-01` | |
| `modules/http_route_configs` | `2025-07-01` | |

---

## Breaking Schema Changes

### `storages`

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

### `dapr_components`

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

### `certificates`

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

### `managed_certificates`

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

---

## Ephemeral Variables and Version Trackers

Several variables are now marked as `ephemeral = true`, meaning their values are not stored in Terraform state. Each ephemeral variable requires a corresponding `_version` variable that must be incremented when the secret value changes (to trigger re-application).

| Ephemeral Variable | Version Tracker |
|---|---|
| `shared_key` | `shared_key_version` |
| `certificate_password` | `certificate_password_version` |
| `dapr_ai_connection_string` | `dapr_ai_connection_string_version` |
| `dapr_ai_instrumentation_key` | `dapr_ai_instrumentation_key_version` |

---

## Log Analytics Backward Compatibility

The `log_analytics_workspace` variable (resource ID-based) is preserved for backward compatibility. It continues to auto-fetch the primary shared key and customer ID.

The following variables are removed; use `app_logs_configuration` instead:

- `log_analytics_workspace_customer_id` → `app_logs_configuration.log_analytics_configuration.customer_id`
- `log_analytics_workspace_destination` → `app_logs_configuration.destination`
- `log_analytics_workspace_primary_shared_key` → `shared_key` (ephemeral)

---

## Provider Version Changes

| Provider | Before | After |
|---|---|---|
| `azapi` | `~> 2.6` | `~> 2.7` |

---

## Submodule Interface Changes

### `enable_telemetry` removed from per-instance variable types

`enable_telemetry` has been removed from every child resource variable type (e.g. `dapr_components`, `storages`, `certificates`, etc.). Telemetry is now controlled at the root module level via `var.enable_telemetry`, which is passed to all submodules automatically.

**Before:**
```hcl
dapr_components = {
  "my-component" = {
    name             = "my-component"
    enable_telemetry = false  # per-instance — no longer supported
    ...
  }
}
```

**After:** remove `enable_telemetry` from all per-instance maps. To disable telemetry, set it on the root module:
```hcl
module "managed_environment" {
  ...
  enable_telemetry = false
}
```

### `location` removed from non-location-bearing submodule variable types

`location` has been removed from the variable types for submodules whose child resources do not have a location property in the Azure API: `dapr_components`, `dapr_subscriptions`, `dot_net_components`, `http_route_configs`, `java_components`, `maintenance_configurations`, and `storages`.

`location` is **retained** in `certificates` and `managed_certificates` because those resources accept a location in the API body.

**Before:**
```hcl
dapr_components = {
  "my-component" = {
    name     = "my-component"
    location = "eastus"  # no longer accepted for these submodules
    ...
  }
}
```

**After:** remove `location` from instances of the above 7 submodule types.

---

## API Version Change

The main resource API version has been upgraded from `2025-02-02-preview` to `2025-07-01` (GA).
