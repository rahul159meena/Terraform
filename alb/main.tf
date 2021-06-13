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

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = var.listener_details["forward_protocol"]
  ssl_policy        = var.listener_details["forward_protocol"] == "HTTP" ? null : var.listener_details["ssl_policy"]
  certificate_arn   = var.listener_details["forward_protocol"] == "HTTP" ? null : var.listener_details["certificate_arn"]

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

resource "aws_lb_listener" "alb_http_listener" {
  count             = var.listener_details["forward_protocol"] == "HTTPS" ? 1 : 0
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
