variable "dot_net_components" {
  type = map(object({
    component_type = optional(any)
    configurations = optional(list(object({
      property_name = optional(string)
      value         = optional(string)
    })))
    name = string
    service_binds = optional(list(object({
      name       = optional(string)
      service_id = optional(string)
    })))
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**component_type**
Type of the .NET Component.

**configurations**
List of .NET Components configuration properties

**service_binds**
List of .NET Components that are bound to the .NET component
**name**
The name of the resource.
DESCRIPTION
}
