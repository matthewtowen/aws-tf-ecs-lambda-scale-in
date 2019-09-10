resource "aws_autoscaling_lifecycle_hook" "lifecycle" {
  name                    = "${var.environment}-${var.name}-lifecycle"
  autoscaling_group_name  = "${var.autoscaling_group_name}"
  default_result          = "ABANDON"
  heartbeat_timeout       = 900
  lifecycle_transition    = "autoscaling:EC2_INSTANCE_TERMINATING"
  notification_target_arn = "${aws_sns_topic.lifecycle.arn}"
  role_arn                = "${aws_iam_role.lifecycle_sns.arn}"
}