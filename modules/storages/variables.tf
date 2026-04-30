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

variable "azure_file" {
  description = <<DESCRIPTION
Azure file properties

- `access_mode` - Access mode for storage
- `account_key` - Storage account key for azure file.
- `account_key_vault_properties` - Storage account key stored as an Azure Key Vault secret.
  - `identity` - Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
  - `key_vault_url` - URL pointing to the Azure Key Vault secret.
- `account_name` - Storage account name for azure file.
- `share_name` - Azure file share name.

DESCRIPTION
  type = object({
    access_mode = optional(any)
    account_key = optional(string)
    account_key_vault_properties = optional(object({
      identity      = optional(string)
      key_vault_url = optional(string)
    }))
    account_name = optional(string)
    share_name   = optional(string)
  })
  default = null
}

variable "nfs_azure_file" {
  description = <<DESCRIPTION
NFS Azure file properties

- `access_mode` - Access mode for storage
- `server` - Server for NFS azure file. Specify the Azure storage account server address.
- `share_name` - NFS Azure file share name.

DESCRIPTION
  type = object({
    access_mode = optional(any)
    server      = optional(string)
    share_name  = optional(string)
  })
  default = null
}


variable "account_key" {
  description = <<DESCRIPTION
Storage account key for azure file.
DESCRIPTION
  type        = string
  default     = null
  ephemeral   = true
}


variable "account_key_version" {
  description = <<DESCRIPTION
Version tracker for account_key. Must be set when account_key is provided.
DESCRIPTION
  type        = number
  default     = null
  validation {
    condition     = var.account_key  ==  null  ||  var.account_key_version  !=  null
    error_message = "When account_key is set, account_key_version must also be set."
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

