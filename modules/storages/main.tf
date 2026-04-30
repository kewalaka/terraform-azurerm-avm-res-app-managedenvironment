resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/storages@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  body      = local.resource_body
  replace_triggers_refs = [
    "properties.azureFile.accountName",
    "properties.azureFile.shareName",
    "properties.nfsAzureFile.server",
  ]
  sensitive_body = {
    properties = {
      azureFile = var.azure_file == null ? null : {
        accountKey = var.account_key
      }
    }
  }
  sensitive_body_version = {
    "properties.azureFile.accountKey" = var.account_key_version
  }
  response_export_values = [
    "apiVersion",
    "systemData",
    "type"
  ]
}
