<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-avm-res-app-managedenvironment

Module to deploy Container Apps Managed Environments in Azure.

-> Major version Zero (0.y.z) is for initial development. Anything MAY change at any time. A module SHOULD NOT be considered stable till at least it is major version one (1.0.0) or greater. Changes will always be via new versions being published and no changes will be made to existing published versions. For more details please go to <https://semver.org/>

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.5.0)

- <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) (~> 1.13)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 3.71)

- <a name="requirement_random"></a> [random](#requirement\_random) (~> 3.5)

## Providers

The following providers are used by this module:

- <a name="provider_azapi"></a> [azapi](#provider\_azapi) (~> 1.13)

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 3.71)

- <a name="provider_random"></a> [random](#provider\_random) (~> 3.5)

## Resources

The following resources are used by this module:

- [azapi_resource.dapr_components](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.storages](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azapi_resource.this_environment](https://registry.terraform.io/providers/Azure/azapi/latest/docs/resources/resource) (resource)
- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_resource_group_template_deployment.telemetry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group_template_deployment) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [random_id.telem](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) (resource)
- [azurerm_resource_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_name"></a> [name](#input\_name)

Description: The name of the Container Apps Managed Environment.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: (Required) The name of the resource group in which the Container App Environment is to be created. Changing this forces a new resource to be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_custom_domain_certificate_password"></a> [custom\_domain\_certificate\_password](#input\_custom\_domain\_certificate\_password)

Description: Certificate password for custom domain.

Type: `string`

Default: `null`

### <a name="input_custom_domain_dns_suffix"></a> [custom\_domain\_dns\_suffix](#input\_custom\_domain\_dns\_suffix)

Description: DNS suffix for custom domain.

Type: `string`

Default: `null`

### <a name="input_dapr_application_insights_connection_string"></a> [dapr\_application\_insights\_connection\_string](#input\_dapr\_application\_insights\_connection\_string)

Description: Application Insights connection string used by Dapr to export Service to Service communication telemetry.

Type: `string`

Default: `null`

### <a name="input_dapr_components"></a> [dapr\_components](#input\_dapr\_components)

Description: - `component_type` - (Required) The Dapr Component Type. For example `state.azure.blobstorage`. Changing this forces a new resource to be created.
- `ignore_errors` - (Optional) Should the Dapr sidecar to continue initialisation if the component fails to load. Defaults to `false`
- `init_timeout` - (Optional) The timeout for component initialisation as a `ISO8601` formatted string. e.g. `5s`, `2h`, `1m`. Defaults to `5s`.
- `secret_store_component` - (Optional) Name of a Dapr component to retrieve component secrets from.
- `scopes` - (Optional) A list of scopes to which this component applies.
- `version` - (Required) The version of the component.

---
`metadata` block supports the following:
- `name` - (Required) The name of the Metadata configuration item.
- `secret_name` - (Optional) The name of a secret specified in the `secrets` block that contains the value for this metadata configuration item.
- `value` - (Optional) The value for this metadata configuration item.

---
`secret` block supports the following:
- `name` - (Required) The Secret name.
- `value` - (Required) The value for this secret.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Container App Environment Dapr Component.
- `delete` - (Defaults to 30 minutes) Used when deleting the Container App Environment Dapr Component.
- `read` - (Defaults to 5 minutes) Used when retrieving the Container App Environment Dapr Component.
- `update` - (Defaults to 30 minutes) Used when updating the Container App Environment Dapr Component.

Type:

```hcl
map(object({
    component_type         = string
    ignore_errors          = optional(bool, true)
    init_timeout           = optional(string)
    secret_store_component = optional(string)
    scopes                 = optional(list(string))
    version                = string
    metadata = optional(list(object({
      name        = string
      secret_name = optional(string)
      value       = optional(string)
    })))
    secret = optional(set(object({
      name  = string
      value = string
    })))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create on the Key Vault. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), ["allLogs"])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_enable_telemetry"></a> [enable\_telemetry](#input\_enable\_telemetry)

Description: This variable controls whether or not telemetry is enabled for the module.  
For more information see <https://aka.ms/avm/telemetryinfo>.  
If it is set to false, then no telemetry will be collected.

Type: `bool`

Default: `true`

### <a name="input_infrastructure_resource_group_name"></a> [infrastructure\_resource\_group\_name](#input\_infrastructure\_resource\_group\_name)

Description: Name of the platform-managed resource group created for the Managed Environment to host infrastructure resources.   
If a subnet ID is provided, this resource group will be created in the same subscription as the subnet.  
If not specified, then one will be generated automatically, in the form `ME_<app_managed_environment_name>_<resource_group>_<location>`.

Type: `string`

Default: `null`

### <a name="input_infrastructure_subnet_id"></a> [infrastructure\_subnet\_id](#input\_infrastructure\_subnet\_id)

Description: The existing Subnet to use for the Container Apps Control Plane. **NOTE:** The Subnet must have a `/21` or larger address space.

Type: `string`

Default: `null`

### <a name="input_internal_load_balancer_enabled"></a> [internal\_load\_balancer\_enabled](#input\_internal\_load\_balancer\_enabled)

Description: Should the Container Environment operate in Internal Load Balancing Mode? Defaults to `false`. **Note:** can only be set to `true` if `infrastructure_subnet_id` is specified.

Type: `bool`

Default: `false`

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location.

Type: `string`

Default: `null`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: Controls the Resource Lock configuration for this resource. The following properties can be specified:

- `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.
- `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.

Type:

```hcl
object({
    kind = string
    name = optional(string, null)
  })
```

Default: `null`

### <a name="input_log_analytics_workspace_customer_id"></a> [log\_analytics\_workspace\_customer\_id](#input\_log\_analytics\_workspace\_customer\_id)

Description: The ID for the Log Analytics Workspace to link this Container Apps Managed Environment to.

Type: `string`

Default: `null`

### <a name="input_log_analytics_workspace_destination"></a> [log\_analytics\_workspace\_destination](#input\_log\_analytics\_workspace\_destination)

Description: Destination for Log Analytics (options: 'log-analytics', 'azuremonitor', 'none').

Type: `string`

Default: `"log-analytics"`

### <a name="input_log_analytics_workspace_primary_shared_key"></a> [log\_analytics\_workspace\_primary\_shared\_key](#input\_log\_analytics\_workspace\_primary\_shared\_key)

Description: Primary shared key for Log Analytics.

Type: `string`

Default: `null`

### <a name="input_peer_authentication_enabled"></a> [peer\_authentication\_enabled](#input\_peer\_authentication\_enabled)

Description: Enable peer authentication (Mutual TLS).

Type: `bool`

Default: `false`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.
- `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_storages"></a> [storages](#input\_storages)

Description: - `access_key` - (Required) The Storage Account Access Key.
- `access_mode` - (Required) The access mode to connect this storage to the Container App. Possible values include `ReadOnly` and `ReadWrite`. Changing this forces a new resource to be created.
- `account_name` - (Required) The Azure Storage Account in which the Share to be used is located. Changing this forces a new resource to be created.
- `share_name` - (Required) The name of the Azure Storage Share to use. Changing this forces a new resource to be created.

---
`timeouts` block supports the following:
- `create` - (Defaults to 30 minutes) Used when creating the Container App Environment Storage.
- `delete` - (Defaults to 30 minutes) Used when deleting the Container App Environment Storage.
- `read` - (Defaults to 5 minutes) Used when retrieving the Container App Environment Storage.
- `update` - (Defaults to 30 minutes) Used when updating the Container App Environment Storage.

Type:

```hcl
map(object({
    access_key   = string
    access_mode  = string
    account_name = string
    share_name   = string
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      read   = optional(string)
    }))
  }))
```

Default: `{}`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: (Optional) A mapping of tags to assign to the resource.

Type: `map(string)`

Default: `null`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: - `create` - (Defaults to 30 minutes) Used when creating the Container App Environment.
- `delete` - (Defaults to 30 minutes) Used when deleting the Container App Environment.
- `read` - (Defaults to 5 minutes) Used when retrieving the Container App Environment.
- `update` - (Defaults to 30 minutes) Used when updating the Container App Environment.

Type:

```hcl
object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
  })
```

Default: `null`

### <a name="input_workload_profile"></a> [workload\_profile](#input\_workload\_profile)

Description:   
This lists the workload profiles that will be configured for the Managed Environment.  
This is in addition to the default Consumpion Plan workload profile.

 - `maximum_count` - (Optional) The maximum number of instances of workload profile that can be deployed in the Container App Environment.
 - `minimum_count` - (Optional) The minimum number of instances of workload profile that can be deployed in the Container App Environment.
 - `name` - (Required) The name of the workload profile.
 - `workload_profile_type` - (Required) Workload profile type for the workloads to run on. Possible values include `D4`, `D8`, `D16`, `D32`, `E4`, `E8`, `E16` and `E32`.

Type:

```hcl
set(object({
    maximum_count         = optional(number)
    minimum_count         = optional(number)
    name                  = string
    workload_profile_type = string
  }))
```

Default: `[]`

### <a name="input_zone_redundancy_enabled"></a> [zone\_redundancy\_enabled](#input\_zone\_redundancy\_enabled)

Description: (Optional) Should the Container App Environment be created with Zone Redundancy enabled? Defaults to `false`. Changing this forces a new resource to be created.

Type: `bool`

Default: `true`

## Outputs

The following outputs are exported:

### <a name="output_dapr_components"></a> [dapr\_components](#output\_dapr\_components)

Description: A map of dapr components connected to this environment. The map key is the supplied input to var.storages. The map value is the azurerm-formatted version of the entire dapr\_components resource.

### <a name="output_id"></a> [id](#output\_id)

Description: The ID of the resource.

### <a name="output_name"></a> [name](#output\_name)

Description: The name of the resource

### <a name="output_resource"></a> [resource](#output\_resource)

Description: The Container Apps Managed Environment resource.

### <a name="output_storages"></a> [storages](#output\_storages)

Description: A map of storage shares connected to this environment. The map key is the supplied input to var.storages. The map value is the azurerm-formatted version of the entire storage shares resource.

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->