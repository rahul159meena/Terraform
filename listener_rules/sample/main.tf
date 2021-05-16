module "listener_rule" {
  source       = "git::ssh://git@gitlab.com:ot-client/docasap/tf-modules/listener.git"
  listener_arn = var.listener_arn
  listener_rules_details = [{
    priority         = 89
    path_pattern     = var.path_pattern
    host_header      = []
    http_header      = []
    query_string     = []
    target_group_arn = var.target_group_arn
    },
    {
      priority         = 70
      path_pattern     = []
      host_header      = []
      query_string     = []
      http_header      = var.http_header
      target_group_arn = var.target_group_arn
    },
    {
      priority         = 100
      path_pattern     = []
      query_string     = var.query_string
      host_header      = []
      http_header      = []
      target_group_arn = var.target_group_arn
    },
    {
      priority         = 105
      path_pattern     = []
      query_string     = var.query_string
      host_header      = var.host_header
      http_header      = var.http_header
      target_group_arn = var.target_group_arn
    }
  ]
}
