variable "dapr_components" {
  type = map(object({
    component_type          = optional(string)
    dapr_components_version = optional(string)
    enable_telemetry        = optional(bool)
    ignore_errors           = optional(bool)
    init_timeout            = optional(string)
    location                = string
    metadata = optional(list(object({
      name       = optional(string)
      secret_ref = optional(string)
      value      = optional(string)
    })))
    name                   = string
    scopes                 = optional(list(string))
    secret_store_component = optional(string)
    secrets = optional(list(object({
      identity      = optional(string)
      key_vault_url = optional(string)
      name          = optional(string)
      value         = optional(string)
    })))
    secrets_version = optional(number)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**name**
The name of the resource.

**location**
The location of the resource.

**component_type**
Component type

**metadata**
Component metadata

**scopes**
Names of container apps that can use this Dapr component

**secret_store_component**
Name of a Dapr component to retrieve component secrets from

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**ignore_errors**
Boolean describing if the component errors are ignores

**init_timeout**
Initialization timeout

**secrets**
Collection of secrets used by a Dapr component

**dapr_components_version**
Component version

**secrets_version**
Version tracker for secrets. Must be set when secrets is provided.
DESCRIPTION
}
