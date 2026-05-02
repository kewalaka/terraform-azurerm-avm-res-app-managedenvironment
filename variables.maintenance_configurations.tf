variable "maintenance_configurations" {
  type = map(object({
    enable_telemetry = optional(bool)
    location         = string
    name             = string
    scheduled_entries = list(object({
      duration_hours = number
      start_hour_utc = number
      week_day       = string
    }))
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**location**
The location of the resource.

**scheduled_entries**
List of maintenance schedules for a managed environment.

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**name**
The name of the resource.
DESCRIPTION
}
