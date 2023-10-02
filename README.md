# PBS TF Lambda Event Source Mapping Module

## Installation

### Using the Repo Source

Use this URL for the source of the module. See the usage examples below for more details.

```hcl
github.com/pbs/terraform-aws-lambda-event-source-mapping-module?ref=x.y.z
```

### Alternative Installation Methods

More information can be found on these install methods and more in [the documentation here](./docs/general/install).

## Usage

Creates a Lambda event source mapping.

Integrate this module like so:

```hcl
module "lambda_event_source_mapping" {
  source = "github.com/pbs/terraform-aws-lambda-event-source-mapping-module?ref=x.y.z"

  function_name    = module.lambda.arn
  event_source_arn = module.queue.arn

  # Optional Parameters
}
```

For example, this would be how to use this module to create a Lambda event source mapping for a Lambda function that is triggered by an SQS queue:

```hcl
module "lambda_event_source_mapping" {
  source = "../.."

  function_name    = module.lambda.arn
  event_source_arn = module.queue.arn

  batch_size = 1

  scaling_config = {
    maximum_concurrency = 10
  }
}
```

## Adding This Version of the Module

If this repo is added as a subtree, then the version of the module should be close to the version shown here:

`x.y.z`

Note, however that subtrees can be altered as desired within repositories.

Further documentation on usage can be found [here](./docs).

Below is automatically generated documentation on this Terraform module using [terraform-docs][terraform-docs]

---

[terraform-docs]: https://github.com/terraform-docs/terraform-docs

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.19.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_event_source_mapping.mapping](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_event_source_mapping) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | The name or the ARN of the Lambda function that will be subscribing to events. | `string` | n/a | yes |
| <a name="input_batch_size"></a> [batch\_size](#input\_batch\_size) | The largest number of records that Lambda will retrieve from your event source at the time of invocation. Defaults to 100 for DynamoDB, Kinesis, MQ and MSK, 10 for SQS. | `number` | `null` | no |
| <a name="input_event_source_arn"></a> [event\_source\_arn](#input\_event\_source\_arn) | The event source ARN - this is required for Kinesis stream, DynamoDB stream, SQS queue, MQ broker or MSK cluster. It is incompatible with a Self Managed Kafka source. | `string` | `null` | no |
| <a name="input_function_response_types"></a> [function\_response\_types](#input\_function\_response\_types) | A list of current response type enums applied to the event source mapping for AWS Lambda checkpointing. Only available for SQS and stream sources (DynamoDB and Kinesis). Valid values: ReportBatchItemFailures. | `list(string)` | `null` | no |
| <a name="input_scaling_config"></a> [scaling\_config](#input\_scaling\_config) | Scaling configuration of the event source. Only available for SQS queues. Detailed below. | <pre>object({<br>    maximum_concurrency = optional(number)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_uuid"></a> [uuid](#output\_uuid) | The UUID of the created event source mapping |
