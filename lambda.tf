data "archive_file" "lambda_function" {
  type        = "zip"
  source_file = "${path.module}/files/${var.file_name}"
  output_path = "${path.module}/files/${var.file_name}.zip"
}
resource "aws_lambda_function" "lambda_function" {
  runtime          = "python3.6"
  source_code_hash = data.archive_file.lambda_function.output_base64sha256
  filename         = "${path.module}/files/${var.file_name}.zip"
  function_name    = "${var.name}-${var.environment}-ecs-graceful"
  handler          = "lambda_function.lambda_handler"
  role             = "${aws_iam_role.lambda_graceful_ecs_func_role.arn}"
  }

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.sns_ecs_graceful.arn}"
}

