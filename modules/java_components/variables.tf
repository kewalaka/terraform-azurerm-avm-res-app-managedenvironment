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
The componentType of the resource.
DESCRIPTION
  type        = string
  validation {
    condition     = contains(["SpringBootAdmin", "SpringCloudConfig", "SpringCloudEureka"], var.component_type)
    error_message = "component_type must be one of: [\"SpringBootAdmin\", \"SpringCloudConfig\", \"SpringCloudEureka\"]."
  }
}

variable "configurations" {
  description = <<DESCRIPTION
List of Java Components configuration properties
DESCRIPTION
  type = list(object({
    property_name = optional(string)
    value         = optional(string)
  }))
  default = null
}

variable "ingress" {
  description = <<DESCRIPTION
Java Component Ingress configurations.


DESCRIPTION
  type        = object({})
  default     = null
}

variable "scale" {
  description = <<DESCRIPTION
Java component scaling configurations

- `max_replicas` - Optional. Maximum number of Java component replicas
- `min_replicas` - Optional. Minimum number of Java component replicas. Defaults to 1 if not set

DESCRIPTION
  type = object({
    max_replicas = optional(number)
    min_replicas = optional(number)
  })
  default = null
}

variable "service_binds" {
  description = <<DESCRIPTION
List of Java Components that are bound to the Java component
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

