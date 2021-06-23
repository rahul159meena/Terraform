resource "aws_vpc" "vpc" {
    cidr_block           = var.cidr_block
    instance_tenancy     = var.instance_tenancy
    enable_dns_support   = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags   = {
        Name = var.igw_name
    }
}

resource "aws_subnet" "public_subnet" {
    count                   = length(var.public_subnet_cidr_blocks)
    vpc_id                  = aws_vpc.vpc.id
    availability_zone       = var.public_availability_zones[count.index]
    cidr_block              = var.public_subnet_cidr_blocks[count.index]
    map_public_ip_on_launch = var.map_public_ip_on_launch
    tags                    = merge({ "Name" = format("%s-public-%d", var.name, count.index) }, var.tags)
}
