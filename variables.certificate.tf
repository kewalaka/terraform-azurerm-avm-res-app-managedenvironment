variable "certificates" {
  type = map(object({
    certificate_blob_base64 = optional(string, null)
    certificate_password    = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of certificates to create on the container app environment. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `certificate_blob_base64` - (Optional) The certificate file in PFX or PEM format.
- `certificate_password` - (Optional) The certificate password (private key).

DESCRIPTION
  nullable    = false
}

variable "managed_certificates" {
  type = map(object({
    domain_control_validation = optional(string, null)
    subject_name              = optional(string, null)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of managed certificates to create on the container app environment. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `domain_control_validation` - (Optional) The domain control validation method for the managed certificate.
- `subject_name` - (Optional) The subject name for the managed certificate.

DESCRIPTION
  nullable    = false
}

variable "wait_for_dns_txt_record_resource_id" {
  type        = string
  description = "The resource ID of the DNS TXT record to wait for."
  default     = null
}
