resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/certificates@2024-03-01"
  name      = var.name
  location  = var.location
  parent_id = var.managed_environment.resource_id
  tags      = var.tags

  body = {
    properties = {
      password = var.certificate_password
      value    = var.certificate_blob_base64
    }
  }
}
