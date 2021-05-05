module "security_group" {
  source = "/modules/security_group/"
  sg_name = var.sg_name
  vpc_id  = var.vpc_ID
  sg_ingress = [
    {
      description     = "For HTTPS request at port 443"
      from_port        = 443
      to_port          = 443
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = false
      security_groups = []
    },
    {
      description     = "For HTTP request at port 80"
      from_port        = 80
      to_port          = 80
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = true
      security_groups = []
    },
    {
      description     = "For SSH request at port 22"
      from_port        = 22
      to_port          = 22
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = false
      security_groups = []
    }
  ]

  sg_egress = [
    {
      description     = ""
      from_port        = 0
      to_port          = 0
      protocol        = -1
      cidr_blocks      = ["0.0.0.0/0"]
      self            = false
      security_groups = []
    }
  ]
    sg_name_tag = "securitygroup"
}

module "alb" {
  source                     = "/modules/alb/"
  alb_name                   = var.alb_name
  internal_alb               = var.internal
  alb_security_groups_ids    = var.alb_security_groups_ids
  subnets_id                 = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection
  lb_tags                    = var.alb_tags_map
  alb_log_bucket             = var.alb_log_bucket
  alb_enable_logging         = var.alb_enable_logging 
}

module "target_group" {
  source               = "/modules/target_group/"
  target_group_details = var.tg_details
  vpc_id               = var.vpc_id
  healthy_threshold    = var.healthy_threshold
  unhealthy_threshold  = var.unhealthy_threshold
  timeout              = var.timeout
  interval             = var.interval
  health_check_path    = var.health_check_path
  health_check_port    = var.health_check_port
}

module "tgattachment" {
  source    = "/modules/target_group_attachment/"
  count     = length(var.target_id)
  target_id = var.target_id[count.index]
  tg_arn    = module.target_group.tg_arn
  port      = 80
}

module "alb_listener" {
  source            = "/modules/alb_listener/"
  lb_arn            = module.alb.alb_arn
  tg_arn            = module.target_group.tg_arn
  listener_details  = var.listener_details
  certificat_earn   = var.listener_details["forward_protocol"] == "HTTP" ? null : var.certificate_arn
}

