resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.internal_alb
  load_balancer_type         = "application"
  security_groups            = var.alb_security_groups_ids
  subnets                    = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = var.alb_tags
  idle_timeout               = var.idle_timeout
  drop_invalid_header_fields = var.drop_invalid_header_fields
  access_logs {
    enabled         = var.alb_enable_logging
    bucket          = var.alb_enable_logging == false ? "" : var.alb_log_bucket
    prefix          = var.alb_enable_logging == false ? "" : var.prefix
  }
}