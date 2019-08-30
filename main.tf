resource "aws_iam_policy" "LambdaExecutionRole_access" {
  name   = "${var.environment}-LambdaExecutionRole-access"
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

resource "aws_iam_role" "LambdaExecutionRole" {
  name = "${var.name}-${var.environment}-LambdaExecutionRole"
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

resource "aws_iam_policy_attachment" "LambdaExecutionRole_attachment" {
  name  = "${var.environment}-LambdaExecutionRole-attachment"
  roles = ["${aws_iam_role.LambdaExecutionRole.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_policy_attachment" "LambdaExecutionRole_attachment_action" {
  name  = "${var.environment}-LambdaExecutionRole-attachment-action"
  roles = ["${aws_iam_role.LambdaExecutionRole.name}"]
  policy_arn = "${aws_iam_policy.LambdaExecutionRole_access.arn}"
}



