resource "aws_lb_listener_rule" "listener_rules" {
  count = length(var.listener_rules_details)
  listener_arn = var.listener_arn
  priority = var.listener_rules_details[count.index].priority
  action {
    type             = "forward"
    target_group_arn = var.listener_rules_details[count.index].target_group_arn
  }

  dynamic "condition" {
    for_each = length(var.listener_rules_details[count.index].path_pattern) > 0 ? var.listener_rules_details[count.index].path_pattern : []
    content {
      path_pattern {
        values = var.listener_rules_details[count.index].path_pattern
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.listener_rules_details[count.index].host_header) > 0 ? var.listener_rules_details[count.index].host_header : []
    content {
      host_header {
        values = var.listener_rules_details[count.index].host_header
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.listener_rules_details[count.index].http_header) > 0 ? var.listener_rules_details[count.index].http_header : []
    content {
      http_header {
        http_header_name = condition.value["http_header_name"]
        values           = condition.value["values"]
      }
    }
  }

  dynamic "condition" {
    for_each = length(var.listener_rules_details[count.index].query_string) > 0 ? var.listener_rules_details[count.index].query_string : []
    content {
      query_string {
        key   = condition.value["key"]
        value = condition.value["value"]
      }
    }
  }

}
