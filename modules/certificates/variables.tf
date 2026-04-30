variable "name" {
  description = <<DESCRIPTION
The name of the resource.
DESCRIPTION
  type        = string
}

variable "parent_id" {
  description = <<DESCRIPTION
The parent resource ID for this resource.
DESCRIPTION
  type        = string
}

variable "location" {
  description = <<DESCRIPTION
The location of the resource.
DESCRIPTION
  type        = string
}

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  description = <<DESCRIPTION
(Optional) Tags of the resource.
DESCRIPTION
  type        = map(string)
  default     = null
}

variable "certificate_key_vault_properties" {
  description = <<DESCRIPTION
Properties for a certificate stored in a Key Vault.

- `identity` - Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
- `key_vault_url` - URL pointing to the Azure Key Vault secret that holds the certificate.

DESCRIPTION
  type = object({
    identity      = optional(string)
    key_vault_url = optional(string)
  })
  default = null
}

variable "password" {
  description = <<DESCRIPTION
Certificate password.
DESCRIPTION
  type        = string
  default     = null
  ephemeral   = true
}

variable "value" {
  description = <<DESCRIPTION
PFX or PEM blob
DESCRIPTION
  type        = any
  default     = null
  ephemeral   = true
}


variable "password_version" {
  description = <<DESCRIPTION
Version tracker for password. Must be set when password is provided.
DESCRIPTION
  type        = number
  default     = null
  validation {
    condition     = var.password  ==  null  ||  var.password_version  !=  null
    error_message = "When password is set, password_version must also be set."
  }
}

variable "value_version" {
  description = <<DESCRIPTION
Version tracker for value. Must be set when value is provided.
DESCRIPTION
  type        = number
  default     = null
  validation {
    condition     = var.value  ==  null  ||  var.value_version  !=  null
    error_message = "When value is set, value_version must also be set."
  }
}

variable "enable_telemetry" {
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  type        = bool
  default     = true
  nullable    = false
}

