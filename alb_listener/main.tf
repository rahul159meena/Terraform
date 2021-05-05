resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = var.lb_arn
  port              = var.listener_details["forward_port"]
  protocol          = var.listener_details["forward_protocol"]
  ssl_policy        = var.listener_details["forward_protocol"] == "HTTP" ? null : var.listener_details["ssl_policy"]
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.tg_arn
  }
}

resource "aws_lb_listener" "alb_http_listener" {
  count             = var.listener_details["forward_protocol"] == "HTTPS" ? 1 : 0
  load_balancer_arn = var.lb_arn
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
