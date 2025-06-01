resource "aws_sns_topic" "infra_alerts" {
  name = "infra-alerts"
}

resource "aws_sns_topic_subscription" "email_alert" {
  topic_arn = aws_sns_topic.infra_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com"  
}
