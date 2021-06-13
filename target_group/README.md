# target_group

## This module will create a Target Group along side a variety of related information:
 - Target Group
 - Health Check
 - Target Group Attachment

### Usage
***main.tf***
```hcl
module "target_group_and_target_group_attachment" {
  source               = ""
  target_group_details = var.target_group_details
  vpc_id               = var.vpc_id
  healthy_threshold    = var.healthy_threshold
  unhealthy_threshold  = var.unhealthy_threshold
  timeout              = var.timeout
  interval             = var.interval
  health_check_path    = var.health_check_path
  health_check_port    = var.health_check_port
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start
  target_ids           = var.target_ids
  port                 = 80
}
```

***variables.tf***
```hcl
#Variables for TargetGroup
variable "target_group_details" {
  description = "Some essential details of TargetGroup"
  type        = map(any)
  default     = {
    target_group_name     = "da-TG"
    target_group_port     = 80
    target_group_protocol = "HTTP"
    target_type           = "instance"
  }
}

variable "vpc_id" {
  description = "VPC ID for your TargetGroup"
  type        = string
  default     = "vpc-0391267e62cf0cff1"
}

variable "healthy_threshold" {
  description = "Number of consecutive health checks successes required before considering an unhealthy target healthy"
  type        = number
  default     = 10
}

variable "unhealthy_threshold" {
  description = "Number of consecutive health check failures required before considering the target unhealthy"
  type        = number
  default     = 10
}

variable "timeout" {
  description = "Amount of time, in seconds, during which no response means a failed health check"
  type        = number
  default     = 3
}

variable "interval" {
  description = "Approximate amount of time, in seconds, between health checks of an individual target"
  type        = number
  default     = 30
}

variable "health_check_path" {
  description = "Path to health-check"
  type        = string
  default     = "/"
}

variable "health_check_port" {
  description = "Port to health-check"
  type        = number
  default     = 80
}

variable "deregistration_delay" {
  description = "Amount time for Load Balancing to wait before changing the state of a deregistering target from draining to unused"
  type        = number
  default     = 90
}

variable "slow_start" {
  description = "Amount time for targets to warm up before the load balancer sends them a full share of requests"
  type        = number
  default     = 100
}

#Variable for TargetGroup attachment
variable "target_ids" {
  description = "This is the TargetID where TG will attach"
  type        = list(string)
  default     = ["i-069894aabebcd6b23", "i-08ed634a42bc9859a"]
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| target_group_details  |  Some essential details of TargetGroup  | map(any)  | not null  | yes  | 
| vpc_id  | VPC ID for your TargetGroup  |  string  | null  | yes  |
| healthy_threshold  | Number of consecutive health checks successes required before considering an unhealthy target healthy | number  |  3  | yes  |
| unhealthy_threshold  |  Number of consecutive health check failures required before considering the target unhealthy  |  number  |  3  | yes  | 
| timeout  |  Amount of time, in seconds, during which no response means a failed health check  | number  |  5  | yes  |
| interval  |  Approximate amount of time, in seconds, between health checks of an individual target  |  string  | 5  | yes  |
| health_check_path |  Path to health-check  |  string  | / | yes |
| health_check_port | Port to health-check | number | 80 | yes |
| target_ids  | Give target_ids which you want to register with your TG  |  string  | null  | yes  |
| port  |  Port on which instance will get registered in Target group  | number  |  null  | yes  |
| deregistration_delay  |  Amount time for Load Balancing to wait before changing the state of a deregistering target from draining to unused  | number | 300 | yes  |
| slow_start  | Amount time for targets to warm up before the load balancer sends them a full share of requests  | number | 0 | yes |
| target_ids | This is the TargetID where Target Group will attach | list(string) | not null | yes |
| port | Port on which instance will get registered in Target group | number | 80 | yes |

### Output


| Name | Description |
| :-----: | :-----------: |
| target_group_arn | This is TargetGroup arn |