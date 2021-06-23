# AWS RDS

## This module will create a RDS along the variety of related information
  - RDS
    - MySQL engine
    - MySQL-5.7
    - Multi AZsMult

### Usage
***main.tf***
```hcl
module "rds" {
    source                  = "git://github.com/PratapSingh13/Terraform.git//rds"
    identifier              = var.identifier_name
    allocated_storage       = var.allocated_storage
    storage_type            = var.storage_type
    engine                  = var.engine
    engine_version          = var.engine_version
    instance_class          = var.instance_class
    username                = var.username
    password                = var.password
    vpc_security_group_ids  = var.vpc_security_group_ids
    skip_final_snapshot     = var.skip_final_snapshot
    parameter_group_name    = aws_db_parameter_group.parameter_group.id
    db_subnet_group_name    = aws_db_subnet_group.subnet_group.id
    backup_retention_period = var.backup_retention_period
    multi_az                = var.multi_az
    name                    = var.name
    subnet_ids              = var.subnet_ids
}
```

***variables.tf***
```hcl
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
```
***output.tf***
```hcl
output "vpc_arn" {
  value       = aws_vpc.vpc.arn
  description = "Amazon Resource Name (ARN) of VPC."
}

output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "The ID of the VPC."
}

output "vpc_cidr_block" {
  value       = aws_vpc.vpc.cidr_block
  description = "The CIDR block of the VPC."
}

output "vpc_instance_tenancy" {
  value       = aws_vpc.vpc.instance_tenancy
  description = "Tenancy of instances spin up within VPC."
}

output "vpc_enable_dns_support" {
  value       = aws_vpc.vpc.enable_dns_support
  description = "Whether or not the VPC has DNS support."
}

output "vpc_enable_dns_hostnames" {
  value       = aws_vpc.vpc.enable_dns_hostnames
  description = "Whether or not the VPC has DNS hostname support."
}

output "vpc_main_route_table_id" {
  value       = aws_vpc.vpc.main_route_table_id
  description = "The ID of the main route table associated with this VPC."
}

output "vpc_default_network_acl_id" {
  value       = aws_vpc.vpc.default_network_acl_id
  description = "The ID of the network ACL created by default on VPC creation."
}

output "vpc_default_security_group_id" {
  value       = aws_vpc.vpc.default_security_group_id
  description = "The ID of the security group created by default on VPC creation."
}

output "vpc_default_route_table_id" {
  value       = aws_vpc.vpc.default_route_table_id
  description = "The ID of the route table created by default on VPC creation."
}
```

### Variables
| Name                        |  Description                                                                                  | Type | Default | Required |
| :------------------------:  | :-------------------------------------------------------------------------------------------: | :------: |  :--------: | :-------------: |
| cidr_block                  | The CIDR block for the VPC                                                                    | `string` | 10.0.0.0/16 | Yes |
| instance_tenancy            | A tenancy option for instances launched into the VPC options are (default, dedicated or host) | `string` | default     | optional |
| enable_dns_support          | A boolean flag to enable/disable DNS support in the VPC                                       | `bool`   | true        | optional |
| enable_dns_hostnames        | A boolean flag to enable/disable DNS hostnames in the VPC                                     | `bool`   | false       | optional |
| name                        | The name for the VPC                                                                          | `string` | null        | optional |

### Output
| Name                          | Description                                                     |
| :---------------------------: | :-------------------------------------------------------------: |
| vpc_arn                       | Amazon Resource Name (ARN) of VPC                               |
| vpc_id                        | The ID of the VPC                                               |
| vpc_cidr_block                | The CIDR block of the VPC                                       |
| vpc_instance_tenancy          | Tenancy of instances spin up within VPC                         |
| vpc_enable_dns_support        | Whether or not the VPC has DNS support                          |
| vpc_enable_dns_hostnames      | Whether or not the VPC has DNS hostname support                 |
| vpc_main_route_table_id       | The ID of the main route table associated with this VPC         |
| vpc_default_network_acl_id    | The ID of the network ACL created by default on VPC creation    |
| vpc_default_security_group_id | The ID of the security group created by default on VPC creation |
| vpc_default_route_table_id    | The ID of the route table created by default on VPC creation    |