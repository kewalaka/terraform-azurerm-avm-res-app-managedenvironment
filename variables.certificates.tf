variable "certificates" {
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**password**
Certificate password.

**password_version**
Version tracker for password. Must be set when password is provided.

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**location**
The location of the resource.

**tags**
(Optional) Tags of the resource.

**value**
PFX or PEM blob

**value_version**
Version tracker for value. Must be set when value is provided.

**name**
The name of the resource.

**certificate_key_vault_properties**
Properties for a certificate stored in a Key Vault.

- `identity` - Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
- `key_vault_url` - URL pointing to the Azure Key Vault secret that holds the certificate.
DESCRIPTION
  type = map(object({
    certificate_key_vault_properties = optional(object({
      identity      = optional(string)
      key_vault_url = optional(string)
    }))
    enable_telemetry = optional(bool)
    location         = string
    name             = string
    password         = optional(string)
    password_version = optional(number)
    tags             = optional(map(string))
    value            = optional(any)
    value_version    = optional(number)
  }))
  default = {}
}
