provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-asjdhkasdh"
  location = "AustraliaEast"
}

resource "azurerm_log_analytics_workspace" "this" {
  location            = azurerm_resource_group.this.location
  name                = "law-asjdhkasdh"
  resource_group_name = azurerm_resource_group.this.name
}

variable "container_apps_environment" {
  type = list(any)
  default = [
    {
      container_app_environment_name      = "mangedenvironment-xx-01S"
      enable_telemetry                    = false
      log_analytics_workspace_destination = "log-analytics"
      zone_redundancy_enabled             = false

      # custom_domain_dns_suffix       = null
    }
  ]
}

module "container_apps_environment" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-app-managedenvironment.git?ref=9c3d0cf988096aa9df8f955f4ba1e960da74feda"

  for_each                                   = { for idx, app in var.container_apps_environment : idx => app }
  name                                       = each.value.container_app_environment_name
  location                                   = "australiaeast"
  resource_group_name                        = azurerm_resource_group.this.name
  enable_telemetry                           = each.value.enable_telemetry
  zone_redundancy_enabled                    = each.value.zone_redundancy_enabled
  log_analytics_workspace_primary_shared_key = azurerm_log_analytics_workspace.this.primary_shared_key
  log_analytics_workspace_customer_id        = azurerm_log_analytics_workspace.this.workspace_id
  log_analytics_workspace_destination        = each.value.log_analytics_workspace_destination
}

output "static_ip_address" {
  value = module.container_apps_environment[0].static_ip_address
}
