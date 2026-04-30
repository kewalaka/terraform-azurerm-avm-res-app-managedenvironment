variable "managed_certificates" {
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

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  type = map(object({
    domain_control_validation = optional(any)
    enable_telemetry          = optional(bool)
    location                  = string
    name                      = string
    subject_name              = optional(string)
    tags                      = optional(map(string))
  }))
  default = {}
}
