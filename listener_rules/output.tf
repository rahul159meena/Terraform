output "listener_rule_pattern_arn" {
  value = aws_lb_listener_rule.listener_rules.*.arn
}