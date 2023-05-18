resource "aws_lambda_event_source_mapping" "mapping" {
  event_source_arn        = var.event_source_arn
  function_name           = var.function_name
  batch_size              = var.batch_size
  function_response_types = var.function_response_types

  dynamic "scaling_config" {
    for_each = var.scaling_config == null ? [] : [var.scaling_config]
    content {
      maximum_concurrency = scaling_config.value.maximum_concurrency
    }
  }
}
