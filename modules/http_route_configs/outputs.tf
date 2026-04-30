output "resource_id" {
  description = "The ID of the created resource."
  value       = azapi_resource.this.id
}

output "name" {
  description = "The name of the created resource."
  value       = azapi_resource.this.name
}

output "api_version" {
  description = "The resource api version"
  value       = try(azapi_resource.this.output.apiVersion, null)
}

output "fqdn" {
  description = "FQDN of the route resource."
  value       = try(azapi_resource.this.output.properties.fqdn, null)
}

output "provisioning_errors" {
  description = "List of errors when trying to reconcile http routes"
  value       = try(azapi_resource.this.output.properties.provisioningErrors, [])
}

output "system_data" {
  description = "Azure Resource Manager metadata containing createdBy and modifiedBy information."
  value       = try(azapi_resource.this.output.systemData, {})
}

output "type" {
  description = "The resource type"
  value       = try(azapi_resource.this.output.type, null)
}

