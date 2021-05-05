# AWS Application Load Balancer

## This module will create a Load Balancer along side a variety of related information:
 - Application Load Balancer 
 - Access log enabled in S3 bucket

### Usage
***main.tf***
```hcl
module "alb" {
  source                     = "../modules/alb/"
  alb_name                   = var.alb_name
  internal_alb               = var.is_internal
  alb_security_groups_ids    = var.alb_security_groups_ids
  subnets_id                 = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection
  lb_tags                    = var.alb_tags_map
  alb_log_bucket             = var.alb_log_bucket
  alb_enable_logging         = var.alb_enable_logging 
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

variable "alb_tags_map" {
  description = "Resource Tags"
  type        = map(string)
  default = {
    Name = "test_alb"
  }
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
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| alb_name  |  Name of Load Balancer  | string  | null  | yes  | 
| internal_alb  | If internal true then LB will be internal  |  bool  | true  | yes  |
| alb_security_groups_ids  |  Security groups to be associated with ALB  | list(string)  | not null  | yes  |
| subnets_id  |  A list of subnet IDs to attach to the LB  |  list(string)  | not null  | yes  | 
| enable_deletion_protection  |  Do you want to enable delete protection  | bool  |  false  | yes  |
| lb_tags  |  A map of tags to add to all resources  |  map(string)  | null  | yes  |
| alb_log_bucket  |  Name of S3 bucket where log will store  | string | not null  | yes  |
| alb_enable_logging  |  Do you want logging enable: true for yes  |  bool  | false  | yes  |


### Output


| Name | Description |
| :-----: | :-----------: |
| alb_arn | This will be ALB arn |
| alb_id | ID of the ALB |
| alb_dns | The DNS name of the ALB |
| alb_zoneid | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |

