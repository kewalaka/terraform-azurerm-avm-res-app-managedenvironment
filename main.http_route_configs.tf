module "http_route_configs" {
  source           = "./modules/http_route_configs"
  for_each         = var.http_route_configs
  custom_domains   = each.value.custom_domains
  enable_telemetry = each.value.enable_telemetry
  location         = each.value.location
  name             = each.value.name
  parent_id        = azapi_resource.this.id
  rules            = each.value.rules
}
