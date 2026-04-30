resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/certificates@2025-07-01"
  name      = var.name
  parent_id = var.parent_id
  location  = var.location
  body      = local.resource_body
  sensitive_body = {
    properties = {
      password = var.password
      value    = var.value
    }
  }
  sensitive_body_version = {
    "properties.password" = var.password_version
    "properties.value"    = var.value_version
  }
  tags = var.tags
  response_export_values = [
    "apiVersion",
    "properties.deploymentErrors",
    "properties.expirationDate",
    "properties.issueDate",
    "properties.issuer",
    "properties.publicKeyHash",
    "properties.subjectAlternativeNames",
    "properties.subjectName",
    "properties.thumbprint",
    "properties.valid",
    "systemData",
    "type"
  ]
}
