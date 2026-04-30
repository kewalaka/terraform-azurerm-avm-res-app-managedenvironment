resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/managedCertificates@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  location  = var.location
  body      = local.resource_body
  tags      = var.tags
  response_export_values = [
    "apiVersion",
    "properties.error",
    "properties.validationToken",
    "systemData",
    "type"
  ]
}
