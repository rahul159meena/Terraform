# Variables for Launch Template
locals {
  tags = {
    Managed_By = "Terraform"
  }
}

variable "lt_name" {
  type        = string
  description = "The name of the launch template"
}

variable "lt_description" {
  type        = string
  description = "Description of the launch template"
}

variable "user_data" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instance"
}

variable "ami_id" {
  type        = string
  description = "The ami id that user wants to associate with the launch template"
}

variable "instance_type" {
  type        = string
  description = "The instance type (like micro, medium, large) that user wants to associate with the launch template"
}

variable "key_name" {
  type        = string
  description = "The key name that user wants to associate with the launch template's instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "A list of security group IDs to associate with"
}

variable "lt_tags" {
  type        = map(string)
  description = "The tag associated with the launch template"
}

variable "iam_instance_profile" {
  type        = list(map(string))
  description = "The IAM Instance Profile to launch the instance with"
}

variable "target_group_arn" {
  type        = string
  description = "A aws_alb_target_group ARNs, for use with Application Load Balancing"
}

# Variables for Auto Scaling Group
variable "asg_tags" {
  type        = list(map(string))
  description = "The tag associated with the auto scaling group"
}
variable "asg_name" {
  type        = string
  description = "The name of the auto scaling group"
}

variable "max_size" {
  type        = string
  description = "The maximum size of the Auto Scaling Group"
}

variable "min_size" {
  type        = string
  description = "The minimum size of the Auto Scaling Group"
}

variable "desired_capacity" {
  type        = string
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The list of subnet ids associated with the auto scaling group"
}