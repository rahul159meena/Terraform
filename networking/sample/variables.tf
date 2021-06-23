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
    default     = "cfast-vpc"
}

# Variables for Internet Gateway
variable "igw_name" {
    description = "The name for the Internet Gateway"
    type        = string
    default     = "cfast-IGW"
}

# Variables for Public Subnets
variable "name" {
  type        = string
  description = "The name for the VPC"
  default     = "cfast"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}

# variable "public_availability_zones" {
#     description = "The Availability Zones for the public subnets"
#     type        = list(string)
#     default     = ["us-east-1a", "us-east-1b"]
# }

variable "public_subnet_cidr_blocks" {
    description = "The CIDR blocks for the public subnets"
    type        = list(string)
    default     = ["10.0.0.0/28", "10.0.0.16/28"]
}

variable "map_public_ip_on_launch" {
    description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address"
    type        = string
    default     = true
}