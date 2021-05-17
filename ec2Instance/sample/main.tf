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