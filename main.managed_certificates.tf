module "managed_certificates" {
  source                    = "./modules/managed_certificates"
  for_each                  = var.managed_certificates
  domain_control_validation = each.value.domain_control_validation
  enable_telemetry          = each.value.enable_telemetry
  location                  = each.value.location
  name                      = each.value.name
  parent_id                 = azapi_resource.this.id
  subject_name              = each.value.subject_name
  tags                      = each.value.tags
}
