# SNS Topic for the lifecycle hook
resource "aws_sns_topic" "sns_ecs_graceful" {
  name = "${var.name}-${var.environment}-ecs-graceful"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = "${aws_sns_topic.sns_ecs_graceful.arn}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.lambda_function.arn}"
}