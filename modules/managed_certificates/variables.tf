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

# tflint-ignore: terraform_unused_declarations
variable "tags" {
  description = <<DESCRIPTION
(Optional) Tags of the resource.
DESCRIPTION
  type        = map(string)
  default     = null
}

variable "domain_control_validation" {
  description = <<DESCRIPTION
Selected type of domain control validation for managed certificates.
DESCRIPTION
  type        = any
  default     = null
}

variable "subject_name" {
  description = <<DESCRIPTION
Subject name of the certificate.
DESCRIPTION
  type        = string
  default     = null
}


variable "enable_telemetry" {
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.
DESCRIPTION
  type        = bool
  default     = true
  nullable    = false
}

