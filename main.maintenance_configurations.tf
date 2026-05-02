module "maintenance_configurations" {
  source   = "./modules/maintenance_configurations"
  for_each = var.maintenance_configurations

  location          = each.value.location
  name              = each.value.name
  parent_id         = azapi_resource.this_environment.id
  scheduled_entries = each.value.scheduled_entries
  enable_telemetry  = each.value.enable_telemetry
}
