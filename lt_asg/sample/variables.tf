# Variables for additional tags
variable "additional_tags" {
  type        = map(string)
  description = "These are the additional tags associated with the main tag of launch template"
  default = {
    Owner       = "Siddharth Gupta"
    Location    = "Noida"
    Create_By   = "Siddharth Gupta"
    Reviewed_By = "Rajat Vats"
  }
}
variable "additional_tags_asg" {
  type        = list(map(string))
  description = "These are the additional tags associated with the main tag of auto scaling group"
  default = [{
    key                 = "Owner"
    value               = "Siddharth Gupta"
    propagate_at_launch = true
    }, {
    key                 = "Location"
    value               = "Noida"
    propagate_at_launch = true
    },
    {
      key                 = "Create_By"
      value               = "Siddharth Gupta"
      propagate_at_launch = true
    },
    {
      key                 = "Reviewed_By"
      value               = "Rajat Vats"
      propagate_at_launch = true
    }
  ]
}

# Variables for Launch Template module

variable "launch_template_name" {
  type        = string
  default     = "docasap_launch_template"
  description = "The default launch template name"
}

variable "iam_instance_profile_arn" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with"
}

variable "ami_id" {
  type        = string
  default     = "ami-02181e3fc8fd45173"
  description = "The default ami id that user wants to associate with the launch template"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The default instance type (like micro, medium, large)  that user wants to associate with the launch template"
}

variable "key_name" {
  type        = string
  default     = "sid-key-south-1"
  description = "The default key that user wants to associate with the launch template's instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = ["sg-0d500ab4aadfda95a"]
  description = "The default list of security group that the user wants to associate with the launch template"
}

variable "launch_template" {
  type        = string
  default     = ""
  description = "The default launch template id that user wants to associate with the launch template"
}

# Variables Auto Scaling Group module

variable "asg_name" {
  type        = string
  default     = "docasap_asg"
  description = "The default auto-scaling group name"
}

variable "max_size" {
  type        = string
  default     = "2"
  description = "The maximum size of the Auto Scaling Group"
}

variable "min_size" {
  type        = string
  default     = "2"
  description = "The minimum size of the Auto Scaling Group"
}

variable "desired_capacity" {
  type        = string
  default     = "2"
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "pvt_subnet_ids" {
  type        = list(string)
  default     = ["subnet-04fc11b60e20beb93", "subnet-028a00b61cec61b9d"]
  description = "The list of subnet ids associated with the auto scaling group"
}

variable "target_group_arn" {
  type    = string
  default = ""
  #default     = "arn:aws:elasticloadbalancing:ap-south-1:869140109150:targetgroup/docasap-alb-tg/501e3bb7956c5a26"
  description = "A aws_alb_target_group ARNs, for use with Application or Network Load Balancing"
}

variable "lt_description" {
  type        = string
  default     = "sample docasap launch template"
  description = "Description of the launch template."
}