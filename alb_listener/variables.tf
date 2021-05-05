variable "lb_arn" {
  description = "Provide Load Balancer arn"
  type        = string
}

variable "tg_arn" {
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

