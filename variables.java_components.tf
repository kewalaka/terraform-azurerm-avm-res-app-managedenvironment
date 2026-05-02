variable "java_components" {
  type = map(object({
    component_type = string
    configurations = optional(list(object({
      property_name = optional(string)
      value         = optional(string)
    })))
    enable_telemetry = optional(bool)
    ingress          = optional(object({}))
    location         = string
    name             = string
    scale = optional(object({
      max_replicas = optional(number)
      min_replicas = optional(number)
    }))
    service_binds = optional(list(object({
      name       = optional(string)
      service_id = optional(string)
    })))
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**location**
The location of the resource.

**configurations**
List of Java Components configuration properties

**scale**
Java component scaling configurations

- `max_replicas` - Optional. Maximum number of Java component replicas
- `min_replicas` - Optional. Minimum number of Java component replicas. Defaults to 1 if not set


**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**name**
The name of the resource.

**component_type**
The componentType of the resource.

**ingress**
Java Component Ingress configurations.



**service_binds**
List of Java Components that are bound to the Java component
DESCRIPTION
}
