resource "azapi_resource" "this" {
  type      = "Microsoft.App/managedEnvironments/managedCertificates@2024-03-01"
  name      = var.name
  location  = var.location
  parent_id = var.managed_environment.resource_id
  tags      = var.tags

  body = {
    properties = {
      domainControlValidation = var.domain_control_validation
      subjectName             = var.subject_name
    }
  }
}
