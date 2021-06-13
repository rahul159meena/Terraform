module "target_group_and_target_group_attachment" {
  source                = ""
  target_group_details  = var.target_group_details
  vpc_id                = var.vpc_id
  healthy_threshold     = var.healthy_threshold
  unhealthy_threshold   = var.unhealthy_threshold
  timeout               = var.timeout
  interval              = var.interval
  health_check_path     = var.health_check_path
  health_check_port     = var.health_check_port
  deregistration_delay  = var.deregistration_delay
  slow_start            = var.slow_start
  target_ids            = var.target_ids
  port                  = 80
}