# Fetching latest Ubuntu ami
data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]  
    }     
    filter {
        name   = "virtualization-type"
        values = ["hvm"]  
    }     
}

# Using Data Source for retrieving AZs
data "aws_availability_zones" "available" {
    state = "available"
}

# Creating EC2 instance
resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = data.aws_availability_zones.available.names[0]
  count                       = var.instance_count
  subnet_id                   = var.subnet_id
  tenancy                     = var.tenancy
  monitoring                  = var.monitoring
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids

  tags = {
    Name = var.instance_name
  }
}