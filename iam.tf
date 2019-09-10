resource "aws_iam_policy" "lambda_graceful_ecs_func" {
  name   = "${var.name}-${var.environment}-lambda-graceful-ecs-func"
  path   = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:CompleteLifecycleAction",
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ecs:ListContainerInstances",
                "ecs:DescribeContainerInstances",
                "ecs:UpdateContainerInstancesState",
                "sns:Publish"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role" "lambda_graceful_ecs_func_role" {
  name = "${var.name}-${var.environment}-lambda-graceful-ecs-func-role"
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

resource "aws_iam_policy_attachment" "lambda_graceful_ecs_attachment_func_one" {
  name  = "${var.name}-${var.environment}-lambda_graceful_ecs_attachment_func-one"
  roles = ["${aws_iam_role.lambda_graceful_ecs_func_role.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_policy_attachment" "lambda_graceful_ecs_func_attachment_two" {
  name  = "${var.name}-${var.environment}-lambda_graceful_ecs_func-attachment-two"
  roles = ["${aws_iam_role.lambda_graceful_ecs_func_role.name}"]
  policy_arn = "${aws_iam_policy.lambda_graceful_ecs_func.arn}"
}

resource "aws_iam_role" "sns_graceful_ecs_func" {
  name = "${var.name}-${var.environment}-sns-graceful-ecs-func"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "autoscaling.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "sns_graceful_ecs_attachment_func_one" {
  name  = "${var.name}-${var.environment}-sns-graceful-ecs-attachment-func-one"
  roles = ["${aws_iam_role.sns_graceful_ecs_func.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

