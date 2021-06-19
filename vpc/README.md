# AWS VPC

## This module will create a VPC along the variety of related information
 - CIDR Block
 - DNS Support
 - DNS Hostname
### Usage
***main.tf***
```hcl
module "vpc" {
    source               = "github"
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
}
```

***variables.tf***
```hcl
# Variable for VPC
variable "cidr_block" 
{
    description = "The CIDR Block for VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "instance_tenancy"
{
    description = "A tenancy option for instances launched into the VPC"
    type        =  string
    default     = "default"
}

variable "enable_dns_support"
{
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "enable_dns_hostnames"
{
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
    default     = true
}

variable "name"
{
    description = "The name for the VPC"
    type        = string
    default     = "da-vpc"
}

variable "tags"
{
    description = "A mapping of tags to assign to all resources"
    type        = map(string)
    default     = {}
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