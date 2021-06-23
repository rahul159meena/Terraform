module "vpc" {
    source               = "git://github.com/PratapSingh13/Terraform.git//vpc"
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    vpc_name             = var.vpc_name
    igw_name             = var.igw_name
}