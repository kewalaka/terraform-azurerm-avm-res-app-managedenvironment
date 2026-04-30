variable "dapr_subscriptions" {
  description = <<DESCRIPTION
Map of instances for the submodule with the following attributes:

**bulk_subscribe**
Bulk subscription options

- `enabled` - Enable bulk subscription
- `max_await_duration_ms` - Maximum duration in milliseconds to wait before a bulk message is sent to the app.
- `max_messages_count` - Maximum number of messages to deliver in a bulk message.


**metadata**
Subscription metadata

**pubsub_name**
Dapr PubSub component name

**topic**
Topic name

**enable_telemetry**
This variable controls whether or not telemetry is enabled for the module. For more information see https://aka.ms/avm/telemetryinfo.

**name**
The name of the resource.

**location**
The location of the resource.

**dead_letter_topic**
Deadletter topic name

**routes**
Subscription routes

- `default` - The default path to deliver events that do not match any of the rules.
- `rules` - The list of Dapr PubSub Event Subscription Route Rules.


**scopes**
Application scopes to restrict the subscription to specific apps.
DESCRIPTION
  type = map(object({
    bulk_subscribe = optional(object({
      enabled               = optional(bool)
      max_await_duration_ms = optional(number)
      max_messages_count    = optional(number)
    }))
    dead_letter_topic = optional(string)
    enable_telemetry  = optional(bool)
    location          = string
    metadata          = optional(map(string))
    name              = string
    pubsub_name       = optional(string)
    routes = optional(object({
      default = optional(string)
      rules = optional(list(object({
        match = optional(string)
        path  = optional(string)
      })))
    }))
    scopes = optional(list(string))
    topic  = optional(string)
  }))
  default = {}
}
