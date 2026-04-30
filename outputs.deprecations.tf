# Output deprecations
#
# Note: Terraform 1.15 will introduce a native `deprecated` attribute on output values
# (https://github.com/hashicorp/terraform/issues/42119). Until then, deprecated outputs
# are documented here and kept in outputs.tf for backward compatibility.
#
# The following outputs are candidates for removal in the next major version:
#
#   - `id`  (defined in outputs.tf)
#       Kept as a backward-compatibility alias for `resource_id`.
#       `resource_id` is the canonical AVM output name and should be preferred.
#       Once the `deprecated` attribute is available in the minimum required TF version,
#       this output should be annotated with: deprecated = "Use resource_id instead."
