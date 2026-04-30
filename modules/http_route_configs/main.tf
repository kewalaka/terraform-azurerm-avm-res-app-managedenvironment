resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/httpRouteConfigs@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  body      = local.resource_body
  response_export_values = [
    "apiVersion",
    "properties.fqdn",
    "properties.provisioningErrors",
    "systemData",
    "type"
  ]
}
