output "uuid" {
  description = "The UUID of the created event source mapping"
  value       = module.lambda_event_source_mapping.uuid
}
