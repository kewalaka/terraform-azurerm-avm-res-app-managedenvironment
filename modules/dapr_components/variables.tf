variable "name" {
  description = <<DESCRIPTION
The name of the resource.
DESCRIPTION
  type        = string
}

variable "parent_id" {
  description = <<DESCRIPTION
The parent resource ID for this resource.
DESCRIPTION
  type        = string
}

variable "location" {
  description = <<DESCRIPTION
The location of the resource.
DESCRIPTION
  type        = string
}

variable "component_type" {
  description = <<DESCRIPTION
Component type
DESCRIPTION
  type        = string
  default     = null
}

variable "ignore_errors" {
  description = <<DESCRIPTION
Boolean describing if the component errors are ignores
DESCRIPTION
  type        = bool
  default     = null
}

variable "init_timeout" {
  description = <<DESCRIPTION
Initialization timeout
DESCRIPTION
  type        = string
  default     = null
}

variable "metadata" {
  description = <<DESCRIPTION
Component metadata
DESCRIPTION
  type = list(object({
    name       = optional(string)
    secret_ref = optional(string)
    value      = optional(string)
  }))
  default = null
}

variable "scopes" {
  description = <<DESCRIPTION
Names of container apps that can use this Dapr component
DESCRIPTION
  type        = list(string)
  default     = null
}

variable "secret_store_component" {
  description = <<DESCRIPTION
Name of a Dapr component to retrieve component secrets from
DESCRIPTION
  type        = string
  default     = null
}

variable "secrets" {
  description = <<DESCRIPTION
Collection of secrets used by a Dapr component
DESCRIPTION
  type = list(object({
    identity      = optional(string)
    key_vault_url = optional(string)
    name          = optional(string)
    value         = optional(string)
  }))
  default   = null
  ephemeral = true
}

variable "dapr_components_version" {
  description = <<DESCRIPTION
Component version
DESCRIPTION
  type        = string
  default     = null
}


variable "secrets_version" {
  description = <<DESCRIPTION
Version tracker for secrets. Must be set when secrets is provided.
DESCRIPTION
  type        = number
  default     = null
  validation {
    condition     = var.secrets  ==  null  ||  var.secrets_version  !=  null
    error_message = "When secrets is set, secrets_version must also be set."
  }
}

variable "enable_telemetry" {
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  type        = bool
  default     = true
  nullable    = false
}

