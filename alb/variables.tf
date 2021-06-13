# Variables for ALB
variable "alb_name" {
  description = "Name of ALB"
  type        = string
  default     = "tf-alb"
}

variable "internal_alb" {
  description = "If internal true then LB will be internal"
  type        = bool
  default     = false
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
  default     = false
}

variable "alb_tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "alb_log_bucket" {
  description = "Name of S3 bucket where log will store"
  type        = string
  default     = ""
}

variable "alb_enable_logging" {
  description = "Do you want logging enable: true for yes"
  type        = bool
  default     = false
}

variable "prefix" {
  description = "The S3 bucket prefix Logs are stored in the root if not configured"
  type        = string
  default     = ""
}

#Variables for alb_listener
variable "target_group_arn" {
  description = "Provide Target Group arn"
  type        = string
}

variable "certificate_arn" {
  description = "Provide SSL certificate arn"
  type        = string
  default     = null
}

variable "listener_details" {
  description = "List of some Listener details here"
  type        = map(any)
}
