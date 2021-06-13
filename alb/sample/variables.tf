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

variable "alb_tags" {
  description = "Resource Tags"
  type        = map(string)
  default = {
    Name = "da_alb"
  }
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
  description = "Bucket name for alb logs store"
  type        = string
  default     = "bucket_test"
}

variable "alb_enable_logging" {
  description = "Do you want to enable logging"
  type        = bool
  default     = false
}

variable "prefix" {
  description = "The S3 bucket prefix Logs are stored in the root if not configured"
  type        = string
  default     = ""
}

#Variables for ALB Listeners
variable "listener_details" {
  description = "List of some Listener details here"
  type        = map(any)
  default     = {
    forward_protocol = "HTTP"
    ssl_policy       = ""
    certificate_arn  = ""
  }
}

variable "target_group_arn" {
  description = "Put Target Group arn value"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:836096864812:targetgroup/da-TG/2827a5c3253e780f"
}