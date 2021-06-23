resource "aws_vpc" "vpc" {
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = var.vpc_id
    tags {
        Name = var.igw_name
    }
}