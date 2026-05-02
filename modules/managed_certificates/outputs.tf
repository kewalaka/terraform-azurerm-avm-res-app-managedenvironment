output "api_version" {
  description = "The resource api version"
  value       = try(azapi_resource.this.output.apiVersion, null)
}

output "error" {
  description = "Any error occurred during the certificate provision."
  value       = try(azapi_resource.this.output.properties.error, null)
}

output "name" {
  description = "The name of the created resource."
  value       = azapi_resource.this.name
}

output "resource_id" {
  description = "The ID of the created resource."
  value       = azapi_resource.this.id
}

output "system_data" {
  description = "Azure Resource Manager metadata containing createdBy and modifiedBy information."
  value       = try(azapi_resource.this.output.systemData, {})
}

output "type" {
  description = "The resource type"
  value       = try(azapi_resource.this.output.type, null)
}

output "validation_token" {
  description = "A TXT token used for DNS TXT domain control validation when issuing this type of managed certificates."
  value       = try(azapi_resource.this.output.properties.validationToken, null)
}
