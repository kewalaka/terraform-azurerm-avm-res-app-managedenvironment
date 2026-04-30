provider "azurerm" {
  features {}
}

run "test_gpu_workload_profile_type" {
  command = plan

  variables {
    enable_telemetry                    = false
    location                            = "eastus"
    log_analytics_workspace_destination = "none"
    name                                = "test-gpu-env"
    parent_id                           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-test"
    resource_group_name                 = "rg-test"
    workload_profile = [
      {
        name                  = "GpuNC8T4"
        workload_profile_type = "Consumption-GPU-NC8as-T4"
      }
    ]
  }

  assert {
    condition     = contains([for wp in azapi_resource.this_environment.body.properties.workloadProfiles : wp.workloadProfileType], "Consumption-GPU-NC8as-T4")
    error_message = "GPU workload profiles should accept the supported Consumption-GPU-NC8as-T4 profile type."
  }

  assert {
    condition     = contains([for wp in azapi_resource.this_environment.body.properties.workloadProfiles : wp.workloadProfileType], "Consumption")
    error_message = "A non-consumption workload profile should still include the default Consumption profile to avoid drift."
  }
}
