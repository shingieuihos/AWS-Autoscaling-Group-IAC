provider "aws" {
  region = "us-east-1"
}

# Create a new Security Group for the Auto Scaling Group
resource "aws_security_group" "asg_sg" {
  name        = "shingi-asg-security-group"
  description = "Security group for ASG instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "asg-sg"
  }
}

# Use data source to get AMI and instance type from first EC2
data "aws_instance" "base_instance" {
  instance_id = var.ec2_instance_ids[0]
}

# Create a Launch Template
resource "aws_launch_template" "asg_lt" {
  name_prefix   = "shingi-asg-lt"
  image_id      = data.aws_instance.base_instance.ami
  instance_type = data.aws_instance.base_instance.instance_type
  vpc_security_group_ids = [aws_security_group.asg_sg.id]

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "asg-instance"
    }
  }
}

# Create the Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name                      = "shingi-asg-for-alb"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.asg_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
