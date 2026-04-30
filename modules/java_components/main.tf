resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/javaComponents@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  body      = local.resource_body
  replace_triggers_refs = ["properties.componentType"]
  # Disabled because the body contains a discriminated object type whose
  # discriminator property value is unknown at validate time.
  schema_validation_enabled = false
  response_export_values = [
    "apiVersion",
    "properties.ingress.fqdn",
    "systemData",
    "type"
  ]
}
