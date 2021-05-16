#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "test-sg"
}

variable "vpc_id" {
  description = "Give your vpc id here"
  type        = string
  default     = "vpc-0391267e62cf0cff1"
}

variable "sg_name_tag" {
  description = "Tag name for your Security Group"
  type        = string
  default     = "tf-sg"
}
