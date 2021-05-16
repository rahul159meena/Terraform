resource "aws_lb_target_group" "target_group" {
  name                 = var.target_group_details["target_group_name"]
  port                 = var.target_group_details["target_group_port"]
  protocol             = var.target_group_details["target_group_protocol"]
  target_type          = var.target_group_details["target_type"]
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start


  health_check {
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.timeout
    interval            = var.interval
    path                = var.health_check_path
    port                = var.health_check_port
  }
}

resource "aws_lb_target_group_attachment" "target_group_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  count            = length(var.target_ids)
  target_id        = var.target_ids[count.index]
  port             = var.port
}
