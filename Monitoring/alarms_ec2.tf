# Create CPU alarms for each instance
resource "aws_cloudwatch_metric_alarm" "high_cpu_ec2" {
  for_each = toset(var.ec2_instance_ids)

  alarm_name          = "HighCPU-${each.key}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when EC2 instance CPU exceeds 80%"
  alarm_actions       = [aws_sns_topic.infra_alerts.arn]

  dimensions = {
    InstanceId = each.value
  }
}
