# Variables for EC2_Instance
variable "instance_type" {
  description = "Type of instance to start"
  type        = string
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "Number of Instance do you want to have"
  type        = number
  default     = 1
}

variable "subnet_id" {
  description = "Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host"
  type        = string
  default     = "default"
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = ""
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "instance_name" {
  description = "Tag name for your instance"
  type        = string
  default     = "tf-instance"
}