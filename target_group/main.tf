resource "aws_lb_target_group" "tg" {
  name        = var.target_group_details["tg_name"]
  port        = var.target_group_details["tg_port"]
  protocol    = var.target_group_details["tg_protocol"]
  target_type = var.target_group_details["target_type"]
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    path                = var.health_check_path
    port                = var.health_check_port
  }
}

