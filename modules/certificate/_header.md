# Azure Container Apps Managed Environment Certificate Module

This module is used to create certificates for a Container Apps Environment.

## Usage

```terraform
module "avm-res-app-managedenvironment-certificate" {
  source = "Azure/avm-res-app-managedenvironment/azurerm//modules/certificate"

  certificate = {
    resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.App/managedEnvironments/myEnv"
  }
  
  password = "<sensitive>"
  value    = file()
}
```
