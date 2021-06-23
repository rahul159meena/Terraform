# Variable for VPC
variable "cidr_block" {
    description = "The CIDR Block for VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
    description = "A tenancy option for instances launched into the VPC"
    type        =  string
    default     = "default"
}

variable "enable_dns_support" {
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "enable_dns_hostnames" {
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
    default     = true
}

variable "vpc_name" {
    description = "The name for the VPC"
    type        = string
}

variable "tags" {
    description = "A mapping of tags to assign to all resources"
    type        = map(string)
    default     = {}
}

# Variables for Internet Gateway


variable "igw_name" {
    description = "The name for the Internet Gateway"
    type        = string
}