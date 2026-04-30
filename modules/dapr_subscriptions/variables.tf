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

variable "bulk_subscribe" {
  description = <<DESCRIPTION
Bulk subscription options

- `enabled` - Enable bulk subscription
- `max_await_duration_ms` - Maximum duration in milliseconds to wait before a bulk message is sent to the app.
- `max_messages_count` - Maximum number of messages to deliver in a bulk message.

DESCRIPTION
  type = object({
    enabled               = optional(bool)
    max_await_duration_ms = optional(number)
    max_messages_count    = optional(number)
  })
  default = null
}

variable "dead_letter_topic" {
  description = <<DESCRIPTION
Deadletter topic name
DESCRIPTION
  type        = string
  default     = null
}

variable "metadata" {
  description = <<DESCRIPTION
Subscription metadata
DESCRIPTION
  type        = map(string)
  default     = null
}

variable "pubsub_name" {
  description = <<DESCRIPTION
Dapr PubSub component name
DESCRIPTION
  type        = string
  default     = null
}

variable "routes" {
  description = <<DESCRIPTION
Subscription routes

- `default` - The default path to deliver events that do not match any of the rules.
- `rules` - The list of Dapr PubSub Event Subscription Route Rules.

DESCRIPTION
  type = object({
    default = optional(string)
    rules = optional(list(object({
      match = optional(string)
      path  = optional(string)
    })))
  })
  default = null
}

variable "scopes" {
  description = <<DESCRIPTION
Application scopes to restrict the subscription to specific apps.
DESCRIPTION
  type        = list(string)
  default     = null
}

variable "topic" {
  description = <<DESCRIPTION
Topic name
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

