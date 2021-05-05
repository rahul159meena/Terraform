# alb_listener

## This module will create a alb_listener along side a variety of related information:
 - alb_https_listener
 - alb_http_listener

### Usage
***main.tf***
```hcl
module "alb_listener" {
  source            = "../modules/alb_listener/"
  lb_arn            = module.alb.alb_arn
  tg_arn            = module.targetGroup.tg_arn
  listener_details  = var.listener_details
  certificat_earn   = var.listener_details["forward_protocol"] == "HTTP" ? null : var.certificate_arn
}
```

***variables.tf***
```hcl
#Variables for ALB Listeners
variable "listener_details" {
  default = {
    forward_port      = 80
    forward_protocol  = "HTTP"
    ssl_policy        = ""
  }
}

variable "certificate_arn" {
  description = "Provide your Certificate arn here"
  type        = string
  default     = ""
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| lb_arn  |  This is Load Balancer arn  | string  | null  | yes  | 
| tg_arn  | This is Target Group arn  |  string  | null  | yes  |
| certificate_arn  |  Provide SSL certificate arn  | string  |  null  | yes  |
| listener_details  |  List of some Listener details here  |  map(any)  |  null  | yes  | 
| forward_port  |  Port number to forward request  | number  |  null  | yes  |
| ssl_policy  |  SSL policy for HTTPS request  |  string  | null  | yes  |



### Output


| Name | Description |
| :-----: | :-----------: |
| alb_forward_listener_arn | This is alb_listener Arn |

