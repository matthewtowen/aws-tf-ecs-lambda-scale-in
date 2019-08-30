resource "aws_lambda_function" "lambda_function" {
  runtime          = "python3.6"
  source_code_hash = "${base64sha256(file("${var.file_name}.zip"))}"
  filename         = "${var.file_name}.zip"
  function_name    = "${var.name}-${var.environment}-ecs-asg-fleet-lambda
  handler          = "lambda_function.lambda_handler"
  role             = "${aws_iam_role.LambdaExecutionRole.arn}"
  }

