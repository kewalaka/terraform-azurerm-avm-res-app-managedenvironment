resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/daprSubscriptions@2025-10-02-preview"
  name      = var.name
  parent_id = var.parent_id
  body      = local.resource_body
  replace_triggers_refs = [
    "properties.pubsubName",
    "properties.topic",
  ]
  response_export_values = [
    "apiVersion",
    "systemData",
    "type"
  ]
}
