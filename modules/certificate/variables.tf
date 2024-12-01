variable "name" {
  description = "The name of the certificate resource."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location of the certificate resource."
  type        = string
  nullable    = false
}

variable "managed_environment" {
  type = object({
    resource_id = string
  })
  description = <<DESCRIPTION
  (Required) The Container Apps Managed Environment ID where the certificate resource will be created.

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

variable "certificate_password" {
  description = "The certificate password (private key)."
  default     = null
  type        = string
}

variable "certificate_blob_base64" {
  description = "The certificate file in PFX or PEM format."
  default     = null
  type        = string
}
