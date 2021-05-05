resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.internal_alb
  load_balancer_type         = "application"
  security_groups            = var.alb_security_groups_ids
  subnets                    = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.lb_tags
  access_logs {
  bucket          = var.alb_log_bucket
  prefix          = format("%s-alb", var.alb_name)
  enabled         = var.alb_enable_logging
  }
}

