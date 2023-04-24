provider "aws" {
  # access_key = "<Your Access Key>"
  # secret_key = "<Your Secret Key>"
  region = "us-east-1"
  # shared_config_files      = ["C:/Users/PHT/.aws/config"]
  shared_credentials_files = ["C:/Users/thuph5/.aws/credentials"]
  profile                  = "default"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.zip_file
}

resource "aws_lambda_function" "first_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = var.zip_file
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "greet_lambda.lambda_handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.7"
  depends_on = [
    aws_iam_role_policy_attachment.lambda_logs,
    aws_cloudwatch_log_group.lambda_logs_cloudwatch,
  ]
  environment {
    variables = {
      greeting = "Hello"
    }
  }
}

# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "lambda_logs_cloudwatch" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
}