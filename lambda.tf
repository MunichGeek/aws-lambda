resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "archive_file" "test-function-zip" {
  type        = "zip"
  source_file = "test-function.py"
  output_path = "test-function.zip"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = "lambda_function_name"
  filename      = data.archive_file.test-function-zip.output_path
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "test-function.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = data.archive_file.test-function-zip.output_base64sha256
}
