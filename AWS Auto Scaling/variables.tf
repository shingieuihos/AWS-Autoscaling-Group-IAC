variable "vpc_id" {
  description = "VPC ID for the Auto Scaling Group"
  type        = string
  default     = "vpc-085ca11b340851223"
}

variable "subnet_ids" {
  description = "Subnets to launch ASG instances"
  type        = list(string)
  default     = ["subnet-02bf6269854a46c62", "subnet-038d2c5fc0a323c69"]
}

variable "ec2_instance_ids" {
  description = "Reference EC2 instance(s) for AMI and instance type"
  type        = list(string)
  default     = ["i-038228912e3ceff3b", "i-0be65ed59418be096"]
}
