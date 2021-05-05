variable "target_group_details" {
  description = "Some essential details of TargetGroup"
  type        = map(any)
}

variable "vpc_id" {
  description = "VPC ID for your TargetGroup"
  type        = string
}

variable "healthy_threshold" {
  description = "Number of healthy thresold you want"
  type        = number
}

variable "unhealthy_threshold" {
  description = "Number of Un-healthy thresold you want"
  type        = number
}

variable "timeout" {
  description = "Give timeout duration"
  type        = number
}

variable "interval" {
  description = "Interval"
  type        = number
}

variable "health_check_path" {
  description = "Path to health-check"
  type        = string
}

variable "health_check_port" {
  description = "Port to health-check"
  type        = number
}
