resource "azapi_resource" "this" {
  location  = var.location
  name      = var.name
  parent_id = var.parent_id
  type      = "Microsoft.App/managedEnvironments/certificates@2025-07-01"
  body      = local.resource_body
  replace_triggers_refs = [
    "properties.certificateKeyVaultProperties.keyVaultUrl",
    "properties.certificateKeyVaultProperties.identity",
  ]
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
}
