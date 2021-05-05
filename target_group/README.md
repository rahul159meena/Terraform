# target_group

## This module will create a Target Group along side a variety of related information:
 - Target Group
 - Health Check

### Usage
***main.tf***
```hcl
module "targetGroup" {
  source               = "../modules/target_group/"
  target_group_details = var.tg_details
  vpc_id               = var.vpc_id
  healthy_threshold    = var.healthy_threshold
  unhealthy_threshold  = var.unhealthy_threshold
  timeout              = var.timeout
  interval             = var.interval
  health_check_path    = var.health_check_path
  health_check_port    = var.health_check_port
}
```

***variables.tf***
```hcl
#Variables for TargetGroup
variable "tg_details" {
  default = {
    tg_name     = "da-TG"
    tg_port     = 80
    tg_protocol = "HTTP"
    target_type = "instance"
  }
}

variable "vpc_id" {
  default = "vpc-0391267e62cf0cff1"
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| target_group_details  |  Some essential details of TargetGroup  | map(any)  | null  | yes  | 
| vpc_id  | VPC ID for your TargetGroup  |  string  | null  | yes  |
| healthy_threshold  |  Number of healthy thresold you want  | number  |  null  | yes  |
| unhealthy_threshold  |  Number of un-healthy thresold you want  |  number  |  null  | yes  | 
| timeout  |  Give timeout duration  | number  |  null  | yes  |
| interval  |  SSL policy for HTTPS request  |  string  | null  | yes  |
| health_check_path |  Path to health-check  |  string  | null | yes |
| health_check_port | Port to health-check | number | null | yes |



### Output


| Name | Description |
| :-----: | :-----------: |
| tg_arn | This is TargetGroup arn |

