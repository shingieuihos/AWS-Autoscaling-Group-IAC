# Alarm on unhealthy targets in ALB
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "ALB-Unhealthy-Hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "One or more unhealthy targets in ALB"
  alarm_actions       = [aws_sns_topic.infra_alerts.arn]

  dimensions = {
    LoadBalancer = aws_lb.app_lb.name
    TargetGroup  = aws_lb_target_group.alb_tg.name
  }
}
