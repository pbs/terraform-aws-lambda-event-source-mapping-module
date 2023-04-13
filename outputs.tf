output "uuid" {
  description = "The UUID of the created event source mapping"
  value       = aws_lambda_event_source_mapping.mapping.uuid
}
