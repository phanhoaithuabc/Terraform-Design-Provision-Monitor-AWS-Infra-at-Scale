# TODO: Define the variable for aws_region
variable "lambda_function_name" {
  default = "lambda_1"
}

variable "source_file" {
  default = "greet_lambda.py"
}

variable "zip_file" {
  default = "lambda_function_payload.zip"
}