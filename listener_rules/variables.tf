# Variables for Listener Rules
variable "listener_arn" {
  type        = string
  description = "The ARN of the listener to which to attach the rule"
}


variable "listener_rules_details" {
  type = list(object(
    {
      priority         = number
      path_pattern     = list(any)
      host_header      = list(any)
      http_header      = list(any)
      query_string     = list(any)
      target_group_arn = string
    }
  ))
  description = " Map of single of multiple listener rules details which includes priority, path_pattern, host_header , target_group_arn. See README for usage"
}
