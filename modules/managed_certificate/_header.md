# Azure Container Apps Managed Environment Managed Certificate Module

This module is used to create managed certificates for a Container Apps Environment.

## Usage

```terraform
module "avm-res-app-managedenvironment-managedcertificate" {
  source = "Azure/avm-res-app-managedenvironment/azurerm//modules/managed_certificate"

  managed_certificate = {
    resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.App/managedEnvironments/myEnv"
  }
  
  domain_control_validation = "TXT"
  subject_name              = "domain.example.com"
}
```
