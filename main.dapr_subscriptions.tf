module "dapr_subscriptions" {
  source            = "./modules/dapr_subscriptions"
  for_each          = var.dapr_subscriptions
  bulk_subscribe    = each.value.bulk_subscribe
  dead_letter_topic = each.value.dead_letter_topic
  enable_telemetry  = each.value.enable_telemetry
  location          = each.value.location
  metadata          = each.value.metadata
  name              = each.value.name
  parent_id         = azapi_resource.this.id
  pubsub_name       = each.value.pubsub_name
  routes            = each.value.routes
  scopes            = each.value.scopes
  topic             = each.value.topic
}
