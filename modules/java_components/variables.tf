variable "component_type" {
  type        = string
  description = <<DESCRIPTION
The componentType of the resource.
DESCRIPTION

  validation {
    condition     = contains(["SpringBootAdmin", "SpringCloudConfig", "SpringCloudEureka"], var.component_type)
    error_message = "component_type must be one of: [\"SpringBootAdmin\", \"SpringCloudConfig\", \"SpringCloudEureka\"]."
  }
}

variable "location" {
  type        = string
  description = <<DESCRIPTION
The location of the resource.
DESCRIPTION
}

variable "name" {
  type        = string
  description = <<DESCRIPTION
The name of the resource.
DESCRIPTION
}

variable "parent_id" {
  type        = string
  description = <<DESCRIPTION
The parent resource ID for this resource.
DESCRIPTION
}

variable "configurations" {
  type = list(object({
    property_name = optional(string)
    value         = optional(string)
  }))
  default     = null
  description = <<DESCRIPTION
List of Java Components configuration properties
DESCRIPTION
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  nullable    = false
}

variable "ingress" {
  type        = object({})
  default     = null
  description = <<DESCRIPTION
Java Component Ingress configurations.


DESCRIPTION
}

variable "scale" {
  type = object({
    max_replicas = optional(number)
    min_replicas = optional(number)
  })
  default     = null
  description = <<DESCRIPTION
Java component scaling configurations

- `max_replicas` - Optional. Maximum number of Java component replicas
- `min_replicas` - Optional. Minimum number of Java component replicas. Defaults to 1 if not set

DESCRIPTION
}

variable "service_binds" {
  type = list(object({
    name       = optional(string)
    service_id = optional(string)
  }))
  default     = null
  description = <<DESCRIPTION
List of Java Components that are bound to the Java component
DESCRIPTION
}
