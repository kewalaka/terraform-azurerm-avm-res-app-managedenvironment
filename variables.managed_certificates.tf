variable "managed_certificates" {
  type = map(object({
    domain_control_validation = optional(any)
    location                  = string
    name                      = string
    subject_name              = optional(string)
    tags                      = optional(map(string))
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**name**
The name of the resource.

**location**
The location of the resource.

**tags**
(Optional) Tags of the resource.

**domain_control_validation**
Selected type of domain control validation for managed certificates.

**subject_name**
Subject name of the certificate.
DESCRIPTION
}
