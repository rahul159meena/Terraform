# AWS Application Load Balancer

## This module will create a Load Balancer along side a variety of related information:
 - Application Load Balancer 
 - Access log enabled in S3 bucket
 - ALB Listeners

### Usage
***main.tf***
```hcl
module "alb_and_alb_listeners" {
  source                                 = "https://gitlab.com/ot-client/docasap/tf-modules/alb.git"
  alb_name                               = var.alb_name
  internal_alb                           = var.internal
  alb_security_groups_ids                = var.alb_security_groups_ids
  subnets_id                             = var.subnets_id
  enable_deletion_protection             = var.enable_deletion_protection
  drop_invalid_header_fields             = var.drop_invalid_header_fields
  idle_timeout                           = var.idle_timeout
  alb_tags                               = var.alb_tags
  alb_log_bucket                         = var.alb_log_bucket
  alb_enable_logging                     = var.alb_enable_logging
  prefix				 = var.prefix
  target_grooup_arn                      = var.target_group_arn
  listener_details                       = var.listener_details
}
```

***variables.tf***
```hcl
# Variables for ALB
variable "alb_name" {
  description = "Name for Load Balancer"
  type        = string
  default     = "test-alb"
}

variable "is_internal" {
  description = "Internal for Load Balancer"
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "Protection from deletion"
  type        = bool
  default     = false
}

variable "subnets_id" {
  description = "Give SubnetIDs"
  type        = list(string)
  default     = ["subnet-019228e2e83037c84", "subnet-00c5f377a8c037c6a"]
}

variable "alb_security_groups_ids" {
  description = "A list of Security Groups"
  type        = list(string)
  default     = ["sg-087b864592b3fd821"]
}

variable "alb_tags" {
  description = "Resource Tags"
  type        = map(string)
  default = {
    Name = "test_alb"
  }
}

variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}

variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "drop_invalid_header_fields" {
  description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
  type        = bool
  default     = false
}

variable "alb_log_bucket" {
    description = "S3 bucket name for alb log storage"
    type        = string
    default     = "alb_logs"
}

variable "alb_enable_logging" {
  description = "Do you want logging enable: true for yes"
  type        = bool
  default     = true
}

variable "prefix" {
  description = "The S3 bucket prefix Logs are stored in the root if not configured"
  type        = string
  default     = ""
}

#Variables for ALB Listeners
variable "listener_details" {
  description = "List of some Listener details here"
  type        = map(any)
  default     = {
    forward_protocol  = "HTTP"
    ssl_policy        = ""
    certificate_arn   = ""
  }
}

variable "target_group_arn" {
  description = "Put Target Group arn value"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:836096864812:targetgroup/da-TG/2827a5c3253e780f"
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| alb_name  |  Name of Load Balancer  | string  | auto-generate name starts with tf-alb  | yes  | 
| internal_alb  | If internal true then LB will be internal  |  bool  | false  | yes  |
| alb_security_groups_ids  |  Security groups to be associated with ALB  | list(string)  | not null  | yes  |
| subnets_id  |  A list of subnet IDs to attach to the LB  |  list(string)  | not null  | yes  | 
| enable_deletion_protection  |  Do you want to enable delete protection  | bool  |  false  | yes  |
| alb_tags  |  A map of tags to add to all resources  |  map(string)  | null  | yes  |
| alb_log_bucket  |  Name of S3 bucket where log will store  | string | not null  | yes  |
| prefix  | The S3 bucket prefix Logs are stored in the root if not configured  | string | null | yes |
| alb_enable_logging  |  Do you want logging enable: true for yes  |  bool  | false  | yes  |
| target_group_arn  | This is Target Group arn  |  string  | not null  | yes  |
| certificate_arn  |  Provide SSL certificate arn  | string  |  null  | yes  |
| listener_details  |  List of some Listener details here  |  map(any)  |  null  | yes  | 
| forward_port  |  Port number to forward request  | number  |  null  | yes  |
| ssl_policy  |  SSL policy for HTTPS request  |  string  | null  | yes  |
| drop_invalid_header_fields | Indicates whether invalid header fields are dropped in application load balancers. Defaults to false | bool |  false | yes | 
| idle_timeout | The time in seconds that the connection is allowed to be idle | number | 60 | yes |

### Output


| Name | Description |
| :-----: | :-----------: |
| alb_arn | This will be ALB arn |
| alb_id | ID of the ALB |
| alb_dns | The DNS name of the ALB |
| alb_zoneid | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |
| alb_forward_listener_arn | This is alb_listener Arn |

### Note 
If you are using `forward_protocol = HTTPS` then you have to provide `certificate_arn` and `ssl_policy`
