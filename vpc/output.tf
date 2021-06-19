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