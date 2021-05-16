#Variables for TargetGroup
variable "target_group_details" {
  description = "Some essential details of TargetGroup"
  type        = map(any)
  default     = {
    target_group_name     = "da-TG"
    target_group_port     = 80
    target_group_protocol = "HTTP"
    target_type           = "instance"
  }
}

variable "vpc_id" {
  description = "VPC ID for your TargetGroup"
  type        = string
  default     = "vpc-0391267e62cf0cff1"
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

variable "deregistration_delay" {
  description = "Amount time for Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = 90
}

variable "slow_start" {
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests"
  type        = number
  default     = 100
}

#Variable for TargetGroup attachment
variable "target_ids" {
  description = "This is the TargetID where TG will attach"
  type        = list(string)
  default     = ["i-069894aabebcd6b23", "i-08ed634a42bc9859a"]
}