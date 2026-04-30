# Output deprecations
#
# Terraform 1.15 will add native `deprecated` attribute support for output values
# (https://github.com/hashicorp/terraform/issues/42119). This file includes the
# `deprecated` argument speculatively — if your Terraform version doesn't support it
# yet it will fail validation (see below). The `check` blocks below provide the same
# warning for older Terraform versions.
#
# Once `>= 1.15` is the minimum required version you can remove the check blocks and
# keep only the `deprecated` attribute on each output.

output "id" {
  description = "DEPRECATED: Use `resource_id` instead. The ID of the container app management environment resource."
  value       = azapi_resource.this_environment.id
  # TODO(TF-1.15): uncomment when >= 1.15 is the minimum required Terraform version
  # (trialled in TF 1.14.8: "An argument named "deprecated" is not expected here")
  # deprecated  = "Use resource_id instead."
}

# check block warning: fires whenever this module is evaluated, alerting consumers that
# `id` exists only for backward compatibility and will be removed in a future major version.
# Since `id` is never an empty string for a provisioned resource, condition is always false
# → warning always fires. Remove once the `deprecated` attribute above is activated (TF >= 1.15).
check "deprecation_output_id" {
  assert {
    condition     = azapi_resource.this_environment.id == ""
    error_message = "The output 'id' is deprecated. Use 'resource_id' instead. The 'id' output will be removed in a future major version."
  }
}
