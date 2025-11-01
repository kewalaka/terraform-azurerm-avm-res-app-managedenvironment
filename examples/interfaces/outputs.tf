output "resource_id" {
  description = "The resource ID of the Container Apps Managed Environment."
  value       = module.managedenvironment.resource_id
}

output "name" {
  description = "The name of the Container Apps Managed Environment."
  value       = module.managedenvironment.name
}

output "managed_identities" {
  description = "The managed identities assigned to the environment."
  value       = module.managedenvironment.managed_identities
}
