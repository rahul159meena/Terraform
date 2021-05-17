# Variables for EC2_Instance
variable "instance_type" {
  description = "Type of instance to start"
  type        = string
  default     = "t3.medium"
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
  default     = "subnet-0b31e117f6ea1bfa2"
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
  default     = "jenkins_key"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = ["sg-0a125f596147fe57b", "sg-07c21d676bdb40f0b"]
}

variable "instance_name" {
  description = "Tag name for your instance"
  type        = string
  default     = "tf-instance"
}