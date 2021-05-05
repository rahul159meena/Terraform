# Variables for ALB
variable "alb_name" {
  description = "Name for Load Balancer"
  type        = string
  default     = "da-alb"
}

variable "internal" {
  description = "Internal for Load Balancer"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Protection from deletion"
  type        = bool
  default     = false
}

variable "subnets_id" {
  description = "Give SubnetIDs"
  type        = list(string)
  default     = ["subnet-019228e2e83037c84", "subnet-00c5f377a8c037c6a"]
}

variable "alb_security_groups_ids" {
  description = "A list of Security Groups"
  type        = list(string)
  default     = ["sg-087b864592b3fd821"]
}

variable "alb_tags_map" {
  description = "Resource Tags"
  type        = map(string)
  default = {
    Name = "da_alb"
  }
}

variable "alb_log_bucket" {
  description = "Bucket name for alb logs store"
  type        = string
  default     = "bucket_test"
}

variable "alb_enable_logging" {
  description = "Do you want to enable logging"
  type        = bool
  default     = true
}

#Variables for TargetGroup
variable "tg_details" {
  default = {
    tg_name     = "da-TG"
    tg_port     = 80
    tg_protocol = "HTTP"
    target_type = "instance"
  }
}

variable "vpc_id" {
  default = "vpc-0391267e62cf0cff1"
}

#Variable for TargetGroup attachment
variable "target_id" {
  description = "This is the TargetID where TG will attach"
  type        = list(string)
  default     = ["i-069894aabebcd6b23", "i-08ed634a42bc9859a"]
}

variable "healthy_threshold" {
  description = "Number of healthy thresold you want"
  type        = number
  default     = 10
}

variable "unhealthy_threshold" {
  description = "Number of Un-healthy thresold you want"
  type        = number
  default     = 10
}

variable "timeout" {
  description = "Give timeout duration"
  type        = number
  default     = 3
}

variable "interval" {
  description = "Interval"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Path to health-check"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port to health-check"
  type        = number
  default     = 80
}

#Variables for ALB Listeners
variable "listener_details" {
  default = {
    forward_port     = 80
    forward_protocol = "HTTP"
    ssl_policy       = ""
  }
}

variable "certificate_arn" {
  description = "Provide your Certificate arn here"
  type        = string
  default     = ""
}

#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "da-test-sg"
}

