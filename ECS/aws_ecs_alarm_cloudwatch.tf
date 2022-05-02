resource "aws_cloudwatch_metric_alarm" "Scale_down" {
  alarm_name          = "${var.app_name}-Scale_down_alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              =  "60" # in seconds
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
      ClusterName=  var.ecsClusterName
      ServiceName = var.app_name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_appautoscaling_policy.ecs_policy_for_scale_in.arn]
}

resource "aws_cloudwatch_metric_alarm" "Scale_up" {
  alarm_name          = "${var.app_name}-Scale_up_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              =  "60" # in seconds
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
      ClusterName=  var.ecsClusterName
      ServiceName = var.app_name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_appautoscaling_policy.ecs_policy_for_scale_out.arn]
}
