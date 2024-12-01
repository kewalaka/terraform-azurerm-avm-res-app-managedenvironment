variable "name" {
  description = "The name of the managed certificate resource."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location of the managed certificate resource."
  type        = string
  nullable    = false
}

variable "managed_environment" {
  type = object({
    resource_id = string
  })
  description = <<DESCRIPTION
  (Required) The Container Apps Managed Environment ID where the managed certificate resource will be created.

  - resource_id - The ID of the Virtual Network.
  DESCRIPTION
  nullable    = false
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "domain_control_validation" {
  description = "The domain control validation method for the managed certificate."
  default     = null
  type        = string

  validation {
    condition     = can(regex("^(CNAME|HTTP|TXT)$", var.domain_control_validation))
    error_message = "The domain control validation method must be 'CNAME', 'HTTP', or 'TXT'."
  }
}

variable "subject_name" {
  description = "The subject name for the managed certificate."
  default     = null
  type        = string
}

variable "wait_for_dns_txt_record" {
  type = object({
    resource_id = string
  })
  description = "The resource ID of the DNS TXT record to wait for."
  default     = null
}
