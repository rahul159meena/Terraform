variable "tg_arn" {
  description = "Provide Target Group arn"
  type        = string
}

variable "target_id" {
  description = "Give targetid which you want to register with your TG"
  type        = string
}

variable "port" {
  description = "Port on which instance will get registered in Target group"
  type        = number
}

