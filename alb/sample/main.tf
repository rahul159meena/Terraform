module "alb_and_alb_listeners" {
  source                                = ""
  alb_name                              = var.alb_name
  internal_alb                          = var.internal
  alb_security_groups_ids               = var.alb_security_groups_ids
  subnets_id                            = var.subnets_id
  enable_deletion_protection            = var.enable_deletion_protection
  drop_invalid_header_fields            = var.drop_invalid_header_fields
  idle_timeout                          = var.idle_timeout
  alb_tags                              = var.alb_tags
  alb_log_bucket                        = var.alb_log_bucket
  alb_enable_logging                    = var.alb_enable_logging
  prefix				= var.prefix
  target_group_arn                      = var.target_group_arn
  listener_details                      = var.listener_details
}
