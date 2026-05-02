variable "maintenance_configurations" {
  type = map(object({
    name = string
    scheduled_entries = list(object({
      duration_hours = number
      start_hour_utc = number
      week_day       = string
    }))
  }))
  default     = {}
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**scheduled_entries**
List of maintenance schedules for a managed environment.
**name**
The name of the resource.
DESCRIPTION
}
