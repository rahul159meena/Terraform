module "security_group" {
  source      = "https://gitlab.com/ot-client/docasap/tf-modules/security_group.git"
  sg_name     = var.sg_name
  vpc_id      = var.vpc_id
  sg_name_tag = var.sg_name_tag 
  sg_ingress  = [
    {
      description      = "For HTTPS request at port 443"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self             = false
      security_groups  = []
    },
    {
      description      = "For HTTP request at port 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self             = true
      security_groups  = []
    },
    {
      description      = "For SSH request at port 22"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
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
