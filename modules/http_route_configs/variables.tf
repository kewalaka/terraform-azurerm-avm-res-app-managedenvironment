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

variable "custom_domains" {
  description = <<DESCRIPTION
Custom domain bindings for Http Routes' hostnames.
DESCRIPTION
  type = list(object({
    binding_type   = optional(any)
    certificate_id = optional(string)
    name           = string
  }))
  default = null
}

variable "rules" {
  description = <<DESCRIPTION
Routing Rules for the Http Route resource.
DESCRIPTION
  type = list(object({
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

