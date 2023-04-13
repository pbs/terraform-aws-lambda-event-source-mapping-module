variable "event_source_arn" {
  description = "The event source ARN - this is required for Kinesis stream, DynamoDB stream, SQS queue, MQ broker or MSK cluster. It is incompatible with a Self Managed Kafka source."
  default     = null
  type        = string
}

variable "batch_size" {
  description = "The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 100 for DynamoDB, Kinesis, MQ and MSK, 10 for SQS."
  default     = null
  type        = number
}

variable "scaling_config" {
  description = "Scaling configuration of the event source. Only available for SQS queues. Detailed below."
  default     = null
  type = object({
    maximum_concurrency = optional(number)
  })
}
