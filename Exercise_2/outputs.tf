# TODO: Define the output variable for the lambda function.
data "aws_lambda_function" "first_lambda" {
  function_name = var.lambda_function_name
  depends_on = [
    aws_lambda_function.first_lambda
  ]
}

output "arn" {
  value = data.aws_lambda_function.first_lambda.arn
  depends_on = [
    aws_lambda_function.first_lambda
  ]
}