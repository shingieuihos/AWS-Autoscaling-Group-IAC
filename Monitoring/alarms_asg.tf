# Alarm if ASG scales out (example: capacity > 1)
resource "aws_cloudwatch_metric_alarm" "asg_scaling_alarm" {
  alarm_name          = "shingi-ASG-Scaling-Alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Auto Scaling Group scaled out to more than 1 instance"
  alarm_actions       = [aws_sns_topic.infra_alerts.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }
}
