# Variables for Listener Rules
variable "listener_arn" {
  type        = string
  description = "The ARN of the listener to which to attach the rule"
  default     = "arn:aws:elasticloadbalancing:ap-south-1:614680000114:listener/app/test-alb/18b252af9fce210a/f75186f14f6891af"
}
variable "target_group_arn" {
  type        = string
  description = "The ARN of the target group to be attached to listener rule"
  default     = "arn:aws:elasticloadbalancing:ap-south-1:614680000114:targetgroup/test-tg/3bee81e6e415a990"
}
variable "path_pattern" {
  type        = list(string)
  description = "Keyword for path based routing"
  #default = [null]
  default = ["Spring3HibernateApp/", "/sample", "/test"]
}
variable "host_header" {
  type        = list(string)
  description = "Keywords host based routing"
  default     = ["spring.abc.com"]
  #default = [null]
}

variable "http_header" {
  type        = list(any)
  description = "HTTP headers details"
  default = [{
    http_header_name = "User-Agent"
    values           = ["*Chrome*"]
    },
    {
      http_header_name = "X-Forwarded-For"
      values           = ["192.168.1.*"]
  }]
}

variable "query_string" {
  type        = list(any)
  description = "Query strings to match"
  default = [{
    key   = "health"
    value = "check"
  }]
}
