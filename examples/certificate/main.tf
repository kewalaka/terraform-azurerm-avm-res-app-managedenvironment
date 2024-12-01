terraform {
  required_version = ">= 1.3.0"
  required_providers {
    # ignore this because we want to force the use of AzAPI v1 within the module without having it used in this example.
    # tflint-ignore: terraform_unused_required_providers
    azapi = {
      source  = "Azure/azapi"
      version = ">= 1.13, < 2.0.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = "australiaeast"
  name     = module.naming.resource_group.name_unique
}

resource "azurerm_log_analytics_workspace" "this" {
  location            = azurerm_resource_group.this.location
  name                = module.naming.log_analytics_workspace.name_unique
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_public_dns_zone" "this" {
  name                = "www.contoso.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_dns_txt_record" "this" {
  name                = "asuid"
  resource_group_name = data.azurerm_dns_zone.test.resource_group_name
  zone_name           = data.azurerm_dns_zone.test.name
  ttl                 = 300

  record {
    value = module.managedenvironment.custom_domain_verification_id
  }
}

module "managedenvironment" {
  source = "../../"
  # source = "Azure/avm-res-app-managedenvironment/azurerm"

  name                = module.naming.container_app_environment.name_unique
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  log_analytics_workspace_customer_id        = azurerm_log_analytics_workspace.this.workspace_id
  log_analytics_workspace_primary_shared_key = azurerm_log_analytics_workspace.this.primary_shared_key

  # certificates = {
  #   "certificate1" = {
  #     name                    = "cert1-${module.naming.container_app_environment.name_unique}"
  #     certificate_blob_base64 = filebase64("certificate.pfx")
  #     certificate_password    = "password"
  #     tags = {
  #       certificate_issued_by = "self-signed" # an example tag
  #     }
  #   }
  # }

  managed_certificates = {
    "managed_certificate1" = {
      name                      = "managed-cert1-${module.naming.container_app_environment.name_unique}"
      domain_control_validation = "TXT"
      wait_for_dns_txt_record   = azurerm_dns_txt_record.this.id
      subject_name              = "www.contoso.com"
      tags = {
        certificate_issued_by = "Azure" # an example tag
      }
    }
  }

  # zone redundancy must be disabled unless we supply a subnet for vnet integration.
  zone_redundancy_enabled = false
}
