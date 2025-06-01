output "asg_name" {
  description = "Auto Scaling Group Name"
  value       = aws_autoscaling_group.asg.name
}

output "asg_security_group_id" {
  description = "Security Group ID for the ASG"
  value       = aws_security_group.asg_sg.id
}
