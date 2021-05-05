# Variables for ALB
variable "alb_name" {
  description = "Name of ALB"
  type        = string
}

variable "internal_alb" {
  description = "If internal true then LB will be internal"
  type        = bool
}

variable "alb_security_groups_ids" {
  description = "Security groups to be associated with ALB"
  type        = list(string)
}

variable "subnets_id" {
  description = "A list of subnet IDs to attach to the LB"
  type        = list(string)
}

variable "enable_deletion_protection" {
  description = "Enable delete protection"
  type        = bool
}

variable "lb_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "alb_log_bucket" {
  description = "Name of S3 bucket where log will store"
  type = string
}

variable "alb_enable_logging" {
  description = "Do you want logging enable: true for yes"
  type = bool
}

