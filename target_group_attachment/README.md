# target_group_attachment

## This module will create a Target Group Attachment along side a variety of related information:


### Usage
***main.tf***
```hcl
module "tgattachment" {
  source    = "../modules/target_group_attachment/"
  count     = length(var.target_id)
  target_id = var.target_id[count.index]
  tg_arn    = module.target_group.tg_arn
  port      = 80
}
```

***variables.tf***
```hcl
#Variable for TargetGroup attachment
variable "target_id" {
  description = "This is the TargetID where TG will attach"
  type        = list(string)
  default     = ["i-069894aabebcd6b23", "i-08ed634a42bc9859a"]
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| tg_arn  |  Provide Target Group arn  | string  | null  | yes  | 
| target_id  | Give targetid which you want to register with your TG  |  string  | null  | yes  |
| port  |  Port on which instance will get registered in Target group  | number  |  null  | yes  |



### Output


| Name | Description |
| :-----: | :-----------: |
| tg_arn | This is TargetGroup arn |

