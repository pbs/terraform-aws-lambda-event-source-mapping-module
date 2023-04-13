module "lambda" {
  source = "github.com/pbs/terraform-aws-lambda-module?ref=1.3.2"

  handler  = "main.lambda_handler"
  filename = "./artifacts/deploy.zip"
  runtime  = "python3.9"

  policy_json = jsonencode({
    Statement = [
      {
        Action   = "logs:CreateLogGroup"
        Effect   = "Allow"
        Resource = "arn:aws:logs:us-east-1:*:*"
      },
      {
        Action = [
          "logs:PutLogEvents",
          "logs:CreateLogStream",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:logs:us-east-1:*:log-group:/aws/lambda/${var.product}*:*",
          "arn:aws:logs:us-east-1:*:log-group:/aws/lambda-insights:*",
        ]
      },
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
        ]
        Effect   = "Allow"
        Resource = module.queue.arn
      }
    ]
    Version = "2012-10-17"
  })

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "queue" {
  source = "github.com/pbs/terraform-aws-sqs-module?ref=0.0.1"

  organization = var.organization
  environment  = var.environment
  product      = var.product
  repo         = var.repo
}

module "lambda_event_source_mapping" {
  source = "../.."

  function_name    = module.lambda.arn
  event_source_arn = module.queue.arn

  batch_size = 1

  scaling_config = {
    maximum_concurrency = 10
  }
}
