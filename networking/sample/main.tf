module "network" {
    source                    = "git://github.com/PratapSingh13/Terraform.git//networking"
    
    # Details for VPC
    cidr_block                = var.cidr_block
    instance_tenancy          = var.instance_tenancy
    enable_dns_support        = var.enable_dns_support
    enable_dns_hostnames      = var.enable_dns_hostnames
    vpc_name                  = var.vpc_name

    # Details for Internet Gateway
    igw_name                  = var.igw_name

    # Details for Public Subnet
    public_subnet_cidr_blocks = var.public_subnet_cidr_blocks
    public_availability_zones = var.public_availability_zones
    map_public_ip_on_launch   = var.map_public_ip_on_launch
    name                      = var.name
}

module "security_group" {
    source      = "git://github.com/PratapSingh13/Terraform.git//security_group"
    sg_name     = var.sg_name
    vpc_id      = module.networking.vpc_id
    sg_name_tag = var.sg_name_tag 
    sg_ingress  = [
    {
      description      = "For MySQL port"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      security_groups  = []
    }
  ]

  sg_egress = [
    {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      security_groups  = []
    }
  ]
}