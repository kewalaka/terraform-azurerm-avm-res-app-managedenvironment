resource "azapi_resource" "this" {
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.App/managedEnvironments/maintenanceConfigurations@2025-07-01"
  body      = local.resource_body
  response_export_values = [
    "apiVersion",
    "systemData",
    "type"
  ]
}
