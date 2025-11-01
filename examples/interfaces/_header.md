# AVM Interfaces Example

This example demonstrates all the standard AVM interfaces supported by the Container Apps Managed Environment module:

- `managed_identities` - User-assigned managed identity
- `diagnostic_settings` - Send logs and metrics to Log Analytics
- `role_assignments` - RBAC role assignment on the environment
- `lock` - Resource lock to prevent deletion

## Features Demonstrated

### Managed Identities

Shows how to assign a user-assigned managed identity to the environment using the standard AVM `managed_identities` interface.

### Diagnostic Settings

Demonstrates sending all logs and metrics to a Log Analytics workspace using the standard AVM `diagnostic_settings` interface.

### Role Assignments

Shows how to assign an RBAC role to a principal on the environment resource using the standard AVM `role_assignments` interface.

### Resource Lock

Demonstrates applying a `CanNotDelete` lock to prevent accidental deletion of the environment using the standard AVM `lock` interface.

## Usage

```hcl
module "managedenvironment" {
  source = "Azure/avm-res-app-managedenvironment/azurerm"

  location                = "australiaeast"
  name                    = "my-cae"
  resource_group_name     = "my-rg"
  log_analytics_workspace = { resource_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/my-law" }
  zone_redundancy_enabled = false

  managed_identities = {
    user_assigned_resource_ids = ["/subscriptions/.../resourceGroups/.../providers/Microsoft.ManagedIdentity/userAssignedIdentities/my-identity"]
  }

  diagnostic_settings = {
    "send-to-law" = {
      workspace_resource_id = "/subscriptions/.../resourceGroups/.../providers/Microsoft.OperationalInsights/workspaces/my-law"
      log_groups            = ["allLogs"]
      metric_categories     = ["AllMetrics"]
    }
  }

  role_assignments = {
    "contributor-example" = {
      principal_id               = "00000000-0000-0000-0000-000000000000"
      role_definition_id_or_name = "Contributor"
    }
  }

  lock = {
    kind = "CanNotDelete"
  }
}
```
