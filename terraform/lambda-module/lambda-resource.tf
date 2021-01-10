locals {
    lambda_zip_location = "${path.module}/outputs/welcome.zip"
}

data "archive_file" "welcome_file" {
  type        = "zip"
  source_file = "${path.module}/lambda-function/welcome.js"
  output_path = local.lambda_zip_location
}


resource "aws_lambda_function" "welcome_lambda" {
  filename      = local.lambda_zip_location
  function_name = "handler"
  role          = aws_iam_role.lambda_role.arn
  handler       = "welcome.handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256(local.lambda_zip_location)

  runtime = "nodejs12.x"
}