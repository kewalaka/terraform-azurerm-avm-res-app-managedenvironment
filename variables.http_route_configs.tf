variable "http_route_configs" {
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**name**
The name of the resource.

**location**
The location of the resource.

**custom_domains**
Custom domain bindings for Http Routes' hostnames.

**rules**
Routing Rules for the Http Route resource.
DESCRIPTION
  type = map(object({
    custom_domains = optional(list(object({
      binding_type   = optional(any)
      certificate_id = optional(string)
      name           = string
    })))
    enable_telemetry = optional(bool)
    location         = string
    name             = string
    rules = optional(list(object({
      description = optional(string)
      routes = optional(list(object({
        action = optional(object({
          prefix_rewrite = optional(string)
        }))
        match = optional(object({
          case_sensitive        = optional(bool)
          path                  = optional(string)
          path_separated_prefix = optional(string)
          prefix                = optional(string)
        }))
      })))
      targets = optional(list(object({
        container_app = string
        label         = optional(string)
        revision      = optional(string)
      })))
    })))
  }))
  default = {}
}
