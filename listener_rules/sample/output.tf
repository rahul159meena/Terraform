output "listener_rule_pattern_arn" {
  value = module.listener_rule.*.listener_rule_pattern_arn
}