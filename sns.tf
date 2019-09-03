# SNS Topic for the lifecycle hook
resource "aws_sns_topic" "lifecycle" {
  name = "${var.name}-${var.environment}-lifecycle"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = "${aws_sns_topic.lifecycle.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.lambda_function.arn}"
}