# EC2_Instance

## This module will create EC2_Instance along side a variety of related information:
 - Association with Public IP
 - Tenancy
 - Monitoring

### Usage
***main.tf***
```hcl
module "ec2_instance" {
  source                      = "../"
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  instance_count              = var.instance_count
  subnet_id                   = var.subnet_id
  tenancy                     = var.tenancy
  monitoring                  = var.monitoring
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  instance_name               = var.instance_name
}
```

***variables.tf***
```hcl
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
```

***output.tf***
```hcl
output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.ec2_instance.*.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = aws_instance.ec2_instance.*.arn
}

output "availability_zone" {
  description = "List of availability zones of instances"
  value       = aws_instance.ec2_instance.*.availability_zone
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.ec2_instance.*.public_ip
}

output "security_groups" {
  description = "List of associated security groups of instances"
  value       = aws_instance.ec2_instance.*.security_groups
}

output "vpc_security_group_ids" {
  description = "List of associated security groups of instances, if running in non-default VPC"
  value       = aws_instance.ec2_instance.*.vpc_security_group_ids
}

output "subnet_id" {
  description = "List of IDs of VPC subnets of instances"
  value       = aws_instance.ec2_instance.*.subnet_id
}

output "instance_state" {
  description = "List of instance states of instances"
  value       = aws_instance.ec2_instance.*.instance_state
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| instance_type  |  Type of instance to start  | string  | not null  | yes  | 
| associate_public_ip_address  | If true, the EC2 instance will have associated public IP address  |  bool   | true  | yes  |
| instance_count  | Number of Instance do you want to have | number  |  1  | yes  |
| subnet_id  |  Subnet ID to launch in  | string |  null  | yes  | 
| tenancy  |  The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host  | string  |  default  | yes  |
| monitoring  |  If true, the launched EC2 instance will have detailed monitoring enabled  |  bool  | false | yes  |
| key_name |  he key name to use for the instance  |  string  | null | yes |
| vpc_security_group_ids | A list of security group IDs to associate with | list(string) | null | yes |
| instance_name  | Tag name for your instance  |  string  | tf-instance  | yes  |
