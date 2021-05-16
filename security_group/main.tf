resource "aws_security_group" "security_group" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.sg_ingress

    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      self            = ingress.value.self
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.sg_egress

    content {
      description     = egress.value.description
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      self            = egress.value.self
      security_groups = egress.value.security_groups
    }
  }
  tags = {
    Name = var.sg_name_tag
  }
}