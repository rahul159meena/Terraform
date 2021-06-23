module "vpc" {
    source               = "git://github.com/PratapSingh13/Terraform.git//networking"
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    vpc_name             = var.vpc_name
}

module "igw" {
    source   = "git://github.com/PratapSingh13/Terraform.git//networking"
    vpc_id   = module.vpc.vpc_id
    igw_name = var.igw_name
}