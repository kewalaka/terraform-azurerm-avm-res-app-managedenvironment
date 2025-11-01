terraform {
  required_version = ">= 1.9, < 2.0"

  required_providers {
    # ignore this because we want to force the use of AzAPI v1 within the module without having it used in this example.
    # tflint-ignore: terraform_unused_required_providers
    azapi = {
      source  = "Azure/azapi"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
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

# Example: Create a user-assigned managed identity to demonstrate managed_identities interface
resource "azurerm_user_assigned_identity" "example" {
  location            = azurerm_resource_group.this.location
  name                = "${module.naming.user_assigned_identity.name_unique}-example"
  resource_group_name = azurerm_resource_group.this.name
}

data "azurerm_client_config" "current" {}

module "managedenvironment" {
  source = "../../"

  location                = azurerm_resource_group.this.location
  name                    = module.naming.container_app_environment.name_unique
  resource_group_name     = azurerm_resource_group.this.name
  log_analytics_workspace = { resource_id = azurerm_log_analytics_workspace.this.id }
  # zone redundancy must be disabled unless we supply a subnet for vnet integration.
  zone_redundancy_enabled = false

  # Demonstrate managed_identities interface
  managed_identities = {
    user_assigned_resource_ids = [azurerm_user_assigned_identity.example.id]
  }

  # Demonstrate diagnostic_settings interface
  diagnostic_settings = {
    "send-to-law" = {
      name                  = "send-to-law"
      workspace_resource_id = azurerm_log_analytics_workspace.this.id
      log_categories        = []
      log_groups            = ["allLogs"]
      metric_categories     = ["AllMetrics"]
    }
  }

  # Demonstrate role_assignments interface
  role_assignments = {
    "contributor-example" = {
      principal_id               = data.azurerm_client_config.current.object_id
      role_definition_id_or_name = "Contributor"
      description                = "Example role assignment on Container Apps Environment"
    }
  }

  # Demonstrate lock interface
  lock = {
    kind = "CanNotDelete"
    name = "env-lock"
  }
}
