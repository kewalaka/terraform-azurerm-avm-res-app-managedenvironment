variable "storages" {
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**azure_file**
Azure file properties

- `access_mode` - Access mode for storage
- `account_key` - Storage account key for azure file.
- `account_key_vault_properties` - Storage account key stored as an Azure Key Vault secret.
  - `identity` - Resource ID of a managed identity to authenticate with Azure Key Vault, or System to use a system-assigned identity.
  - `key_vault_url` - URL pointing to the Azure Key Vault secret.
- `account_name` - Storage account name for azure file.
- `share_name` - Azure file share name.


**nfs_azure_file**
NFS Azure file properties

- `access_mode` - Access mode for storage
- `server` - Server for NFS azure file. Specify the Azure storage account server address.
- `share_name` - NFS Azure file share name.


**account_key**
Storage account key for azure file.

**account_key_version**
Version tracker for account_key. Must be set when account_key is provided.

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**name**
The name of the resource.

**location**
The location of the resource.
DESCRIPTION
  type = map(object({
    account_key         = optional(string)
    account_key_version = optional(number)
    azure_file = optional(object({
      access_mode = optional(any)
      account_key = optional(string)
      account_key_vault_properties = optional(object({
        identity      = optional(string)
        key_vault_url = optional(string)
      }))
      account_name = optional(string)
      share_name   = optional(string)
    }))
    enable_telemetry = optional(bool)
    location         = string
    name             = string
    nfs_azure_file = optional(object({
      access_mode = optional(any)
      server      = optional(string)
      share_name  = optional(string)
    }))
  }))
  default = {}
}
