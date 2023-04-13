# PBS TF lambda event source mapping module

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
