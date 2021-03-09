resource "aws_iam_role" "iam_for_fsharp_lambda" {
  name = "iam_for_fsharp_lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid = ""
      }
    ]
  })
}

resource "aws_lambda_function" "fsharp_example_lambda" {
  filename = "fsharp_example_lambda_payload.zip"
  function_name = "fsharp_example_lambda"
  role = aws_iam_role.iam_for_fsharp_lambda.arn
  handler = "FSharpExampleLambda::FSharpExampleLambda.Function::FunctionHandler"

  source_code_hash = filebase64sha256("fsharp_example_lambda_payload.zip")

  runtime = "dotnetcore3.1"
}
