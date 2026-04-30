data "azapi_client_config" "current" {}

# Fetch the primary shared key from the Log Analytics Workspace (mirrors AzureRM provider behaviour).
# Only used when log_analytics_workspace.resource_id is set and var.shared_key is not provided.
ephemeral "azapi_resource_action" "shared_keys" {
  count = var.log_analytics_workspace != null ? 1 : 0

  action                 = "sharedKeys"
  method                 = "POST"
  resource_id            = var.log_analytics_workspace.resource_id
  type                   = "Microsoft.OperationalInsights/workspaces@2020-08-01"
  response_export_values = ["primarySharedKey"]
}

# Fetch the customer ID from the Log Analytics Workspace resource ID.
data "azapi_resource" "customer_id" {
  count = var.log_analytics_workspace != null ? 1 : 0

  resource_id            = var.log_analytics_workspace.resource_id
  type                   = "Microsoft.OperationalInsights/workspaces@2020-08-01"
  response_export_values = ["properties.customerId"]
}

locals {
  # Effective Log Analytics shared key — use explicit ephemeral var if provided, else auto-fetch.
  log_analytics_key = (
    var.shared_key != null ? var.shared_key : (
      length(ephemeral.azapi_resource_action.shared_keys) > 0 ?
      ephemeral.azapi_resource_action.shared_keys[0].output.primarySharedKey : null
    )
  )

  # Effective app logs configuration — merges var.app_logs_configuration with backward-compat
  # logic from log_analytics_workspace (resource ID-based).
  effective_app_logs_configuration = (
    var.app_logs_configuration != null ? var.app_logs_configuration : (
      var.log_analytics_workspace != null ? {
        destination = "log-analytics"
        log_analytics_configuration = {
          customer_id = try(data.azapi_resource.customer_id[0].output.properties.customerId, null)
        }
      } : null
    )
  )

  # Azure rejects publicNetworkAccess=Enabled when the environment has an internal load balancer.
  effective_public_network_access = (
    var.vnet_configuration != null && var.vnet_configuration.internal == true ? "Disabled" : var.public_network_access
  )

  parent_id = var.parent_id != null ? var.parent_id : (
    var.resource_group_name != null ?
    "/subscriptions/${data.azapi_client_config.current.subscription_id}/resourceGroups/${var.resource_group_name}" :
    null
  )

  # Workload profiles idempotency fix: when dedicated profiles are specified, always add a Consumption
  # profile to avoid drift on subsequent runs (Azure creates one implicitly).
  workload_profiles = (
    var.workload_profiles != null && length(var.workload_profiles) > 0 ? concat(
      [
        for wp in var.workload_profiles : {
          name                = wp.name
          workloadProfileType = wp.workload_profile_type
          minimumCount        = wp.minimum_count
          maximumCount        = wp.maximum_count
        }
        if wp.workload_profile_type != "Consumption"
      ],
      [
        {
          name                = "Consumption"
          workloadProfileType = "Consumption"
          minimumCount        = null
          maximumCount        = null
        }
      ]
    ) : null
  )

  resource_body = {
    kind = var.kind
    properties = {
      appLogsConfiguration = local.effective_app_logs_configuration == null ? null : {
        destination = local.effective_app_logs_configuration.destination
        logAnalyticsConfiguration = try(local.effective_app_logs_configuration.log_analytics_configuration, null) == null ? null : {
          customerId = try(local.effective_app_logs_configuration.log_analytics_configuration.customer_id, null)
        }
      }
      customDomainConfiguration = var.custom_domain_configuration == null ? null : {
        certificateKeyVaultProperties = try(var.custom_domain_configuration.certificate_key_vault_properties, null) == null ? null : {
          identity    = var.custom_domain_configuration.certificate_key_vault_properties.identity
          keyVaultUrl = var.custom_domain_configuration.certificate_key_vault_properties.key_vault_url
        }
        certificateValue = try(var.custom_domain_configuration.certificate_value, null)
        dnsSuffix        = try(var.custom_domain_configuration.dns_suffix, null)
      }
      daprConfiguration           = var.dapr_configuration == null ? null : {}
      infrastructureResourceGroup = var.infrastructure_resource_group
      ingressConfiguration = var.ingress_configuration == null ? null : {
        headerCountLimit              = var.ingress_configuration.header_count_limit
        requestIdleTimeout            = var.ingress_configuration.request_idle_timeout
        terminationGracePeriodSeconds = var.ingress_configuration.termination_grace_period_seconds
        workloadProfileName           = var.ingress_configuration.workload_profile_name
      }
      kedaConfiguration = var.keda_configuration == null ? null : {}
      peerAuthentication = var.peer_authentication == null ? null : {
        mtls = try(var.peer_authentication.mtls, null) == null ? null : {
          enabled = var.peer_authentication.mtls.enabled
        }
      }
      peerTrafficConfiguration = var.peer_traffic_configuration == null ? null : {
        encryption = try(var.peer_traffic_configuration.encryption, null) == null ? null : {
          enabled = var.peer_traffic_configuration.encryption.enabled
        }
      }
      publicNetworkAccess = local.effective_public_network_access
      vnetConfiguration = var.vnet_configuration == null ? null : {
        dockerBridgeCidr       = var.vnet_configuration.docker_bridge_cidr
        infrastructureSubnetId = var.vnet_configuration.infrastructure_subnet_id
        internal               = var.vnet_configuration.internal
        platformReservedCidr   = var.vnet_configuration.platform_reserved_cidr
        platformReservedDnsIP  = var.vnet_configuration.platform_reserved_dns_ip
      }
      workloadProfiles = local.workload_profiles
      zoneRedundant    = var.zone_redundant
    }
  }

  # Resource ID maps for outputs
  certificate_resource_ids = { for ck, cv in module.certificates : ck => { id = cv.resource_id } }
  dapr_component_resource_ids = { for dk, dv in module.dapr_components : dk => { id = dv.resource_id } }
  managed_certificate_resource_ids = { for mck, mcv in module.managed_certificates : mck => { id = mcv.resource_id } }
  storage_resource_ids = { for sk, sv in module.storages : sk => { id = sv.resource_id } }

  role_definition_resource_substring = "/providers/Microsoft.Authorization/roleDefinitions"
}

locals {
  managed_identities = {
    system_assigned_user_assigned = (var.managed_identities.system_assigned || length(var.managed_identities.user_assigned_resource_ids) > 0) ? {
      this = {
        type                       = var.managed_identities.system_assigned && length(var.managed_identities.user_assigned_resource_ids) > 0 ? "SystemAssigned, UserAssigned" : length(var.managed_identities.user_assigned_resource_ids) > 0 ? "UserAssigned" : "SystemAssigned"
        user_assigned_resource_ids = var.managed_identities.user_assigned_resource_ids
      }
    } : {}
    system_assigned = var.managed_identities.system_assigned ? {
      this = {
        type = "SystemAssigned"
      }
    } : {}
    user_assigned = length(var.managed_identities.user_assigned_resource_ids) > 0 ? {
      this = {
        type                       = "UserAssigned"
        user_assigned_resource_ids = var.managed_identities.user_assigned_resource_ids
      }
    } : {}
  }
}

