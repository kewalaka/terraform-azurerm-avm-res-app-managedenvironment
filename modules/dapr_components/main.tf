resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/daprComponents@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  body      = local.resource_body
  replace_triggers_refs = ["properties.componentType"]
  sensitive_body = {
    properties = {
      secrets = var.secrets
    }
  }
  sensitive_body_version = {
    "properties.secrets" = var.secrets_version
  }
  response_export_values = [
    "apiVersion",
    "properties.deploymentErrors",
    "systemData",
    "type"
  ]
}
