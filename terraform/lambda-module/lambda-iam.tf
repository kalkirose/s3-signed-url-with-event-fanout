resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda_role.id

  policy = file("${path.module}/iam/lambda-policy.json")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = file("${path.module}/iam/lambda-assume-policy.json")
}