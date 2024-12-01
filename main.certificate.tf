module "certificate" {
  source = "./modules/certificate"

  for_each = var.certificates

  name                    = each.value.name
  location                = var.location
  managed_environment     = { resource_id = azapi_resource.this_environment.id }
  tags                    = coalesce(each.value.tags, var.tags)
  certificate_blob_base64 = each.value.certificate_blob_base64
  certificate_password    = each.value.certificate_password

  depends_on = [azapi_resource.this_environment]
}

module "managed_certificate" {
  source = "./modules/managed_certificate"

  for_each = var.managed_certificates

  name                      = each.value.name
  location                  = var.location
  managed_environment       = { resource_id = azapi_resource.this_environment.id }
  tags                      = coalesce(each.value.tags, var.tags)
  domain_control_validation = each.value.domain_control_validation
  subject_name              = each.value.subject_name
  wait_for_dns_txt_record   = { resource_id = var.wait_for_dns_txt_record_resource_id }

  depends_on = [azapi_resource.this_environment]
}
