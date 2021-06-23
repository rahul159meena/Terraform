# Variables for RDS
variable "identifier_name" {
    description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier"
    type        = string
}

variable "allocated_storage" {
    description = "The size of the storage you want to allocate with RDS instance"
    type        = number
}

variable "storage_type" {
    description = "What type of storage do you want"
    type        = string
}

variable "engine" {
    description = "The database engine to use"
    type        = string
}

variable "engine_version" {
    description = "The engine version to use"
    type        = number
}

variable "instance_class" {
    description = "The instance type of the RDS instance"
    type        = string
}

variable "username" {
    description = "Username for the master DB user"
    type        = string
}

variable "password" {
    description = "Password for the master DB user"
    type        = string
}

variable "vpc_security_group_ids" {
    description = "List of VPC security groups to associate"
    type        = list(string)
}

variable "skip_final_snapshot" {
    description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
    type        = bool
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