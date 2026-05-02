variable "certificates" {
  type = map(object({
    certificate_key_vault_properties = optional(object({
      identity      = optional(string)
      key_vault_url = optional(string)
    }))
    location         = string
    name             = string
    password         = optional(string)
    password_version = optional(number)
    tags             = optional(map(string))
    value            = optional(any)
    value_version    = optional(number)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**password**
Certificate password.

**password_version**
Version tracker for password. Must be set when password is provided.
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
}
