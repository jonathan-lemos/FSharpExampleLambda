resource "aws_lambda_permission" "fsharp_example_permission" {
  statement_id = "AllowAPIGatewayInvoke"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fsharp_example_lambda.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.fsharp_example_lambda_gateway.execution_arn}/*/*"
}
