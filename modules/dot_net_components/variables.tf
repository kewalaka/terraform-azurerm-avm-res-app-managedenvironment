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
Type of the .NET Component.
DESCRIPTION
  type        = any
  default     = null
}

variable "configurations" {
  description = <<DESCRIPTION
List of .NET Components configuration properties
DESCRIPTION
  type = list(object({
    property_name = optional(string)
    value         = optional(string)
  }))
  default = null
}

variable "service_binds" {
  description = <<DESCRIPTION
List of .NET Components that are bound to the .NET component
DESCRIPTION
  type = list(object({
    name       = optional(string)
    service_id = optional(string)
  }))
  default = null
}


variable "enable_telemetry" {
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  type        = bool
  default     = true
  nullable    = false
}

