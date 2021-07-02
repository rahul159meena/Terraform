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

variable "public_availability_zones" {
    description = "The Availability Zones for the public subnets"
    type        = list(string)
    default     = ["us-east-1a", "us-east-1b"]
}

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

#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "cfast-test-sg"
}


variable "sg_name_tag" {
  description = "Tag name for your Security Group"
  type        = string
  default     = "cfast-tf-sg"
}

# Variables for RDS
variable "identifier_name" {
    description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
    type        = string
    default     = "coinsfast_db"
}

variable "allocated_storage" {
    description = "The size of the storage you want to allocate with RDS instance"
    type        = number
    default     = 20
}

variable "storage_type" {
    description = "What type of storage do you want"
    type        = string
    default     = "gp2"
}

variable "engine" {
    description = "The database engine to use"
    type        = string
    default     = "mysql"
}

variable "engine_version" {
    description = "The engine version to use"
    type        = number
    default     = "5.7"
}

variable "instance_class" {
    description = "The instance type of the RDS instance"
    type        = string
    default     = "db.t3.micro"
}

variable "username" {
    description = "Username for the master DB user"
    type        = string
    default     = "admin"
}

variable "password" {
    description = "Password for the master DB user"
    type        = string
    default     = "admin123"
}

variable "skip_final_snapshot" {
    description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
    type        = bool
    default     = true
}

variable "backup_retention_period" {
    description = "The days to retain backups for. Must be between 0 and 35 and must be greater than 0"
    type        = number
    default     = 7
}

variable "multi_az" {
    description = "Specifies if the RDS instance is multi-AZ"
    type        = bool
    default     = false
}

variable "subnet_ids" {
    description = "List of subnet IDs"
    type        = list(string)
    default     = ["subnet-0a70a6b49cb89ab0c", "subnet-0997c42de863f2529"]
}