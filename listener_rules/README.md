# AWS Listener Rule

- This terraform module will listener rules

### Usage
***main.tf***
```hcl
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
```

***variables.tf***
```hcl
# Variables for Listener Rules
variable "listener_arn" {
  type        = string
  description = "The ARN of the listener to which to attach the rule"
  default     = "arn:aws:elasticloadbalancing:ap-south-1:614680000114:listener/app/test-alb/18b252af9fce210a/f75186f14f6891af"
}
variable "target_group_arn" {
  type        = string
  description = "The ARN of the target group to be attached to listener rule"
  default     = "arn:aws:elasticloadbalancing:ap-south-1:614680000114:targetgroup/test-tg/3bee81e6e415a990"
}
variable "path_pattern" {
  type        = list(string)
  description = "Keyword for path based routing"
  #default = [null]
  default = ["Spring3HibernateApp/", "/sample", "/test"]
}
variable "host_header" {
  type        = list(string)
  description = "Keywords host based routing"
  default     = ["spring.abc.com"]
  #default = [null]
}

variable "http_header" {
  type        = list(any)
  description = "HTTP headers details"
  default = [{
    http_header_name = "User-Agent"
    values           = ["*Chrome*"]
    },
    {
      http_header_name = "X-Forwarded-For"
      values           = ["192.168.1.*"]
  }]
}

variable "query_string" {
  type        = list(any)
  description = "Query strings to match"
  default = [{
    key   = "health"
    value = "check"
  }]
}
```

***output.tf***
```hcl
output "listener_rule_pattern_arn" {
  value = module.listener_rule.*.listener_rule_pattern_arn
}
```

### Variables

| Name  | Description | Type | Default | Required |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: | 
| listener_arn  | The ARN of the listener to which to attach the rule  | string  | not null  | yes  | 
| listener_rules_details  | Map of single of multiple listener rules details which includes priority, path_pattern, host_header , http_header, query_string, target_group_arn. | list(object())  | not null  | yes  |
| priority | The priority for the rule between 1 and 50000. The value of the priority displayed in aws is high for the lower value (For eg 1 will be highest and 50000 is lowest) | number  | -  | yes  |
| path_pattern  | Keyword(s) for path based routing  | list(string) | null  | yes  |
| host_header  | Keyword(s) host based routing  | list(string)  | null  | yes  |
| http_header  | HTTP headers details for routing  | list(any)  | null  | yes  |
| query_string  | Query strings to match for routing | list(string)  | not null  | yes  |
| target_group_arn  | The ARN of the target group to be attached to listener rule  | string  | null  | yes  |


### Output

| Name  | Description |
| :-------------: | :-------------: |
| listener_rule_pattern_arn  | Arn's associated with the listener rules created  |

### Note:

 - The listener rules can be any of the below:
    - Path based routing
    - Host based routing
    - Http Header based 
    - Query String based
 - The user can either provide any empty list (like []) or provide associated values 

 - Please find a sample snap of the listener rules created by the above sample module

