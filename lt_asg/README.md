# AWS Launch Template and Auto Scaling Group

## This module will create a ASG along side a variety of related information:
 - Launch Template
 - Auto Scaling Group

### Usage
***main.tf***
```hcl
module "lt_and_asg" {
  # details for launch template
  source                 = "git::ssh://gitlab.com/ot-client/docasap/tf-modules/asg_lt"
  lt_name                = var.launch_template_name
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  lt_tags                = var.additional_tags
  iam_instance_profile = [{
    arn = var.iam_instance_profile_arn
  }]
  lt_description = var.lt_description
  user_data      = filebase64("../script.sh")

  # details for auto scaling group
  asg_name           = var.asg_name
  max_size           = var.max_size
  min_size           = var.min_size
  desired_capacity   = var.desired_capacity
  subnet_ids         = var.pvt_subnet_ids
  asg_tags           = var.additional_tags_asg
  target_group_arn   = var.target_group_arn
}
```

***variables.tf***
```hcl
# Variables for additional tags
variable "additional_tags" {
  type        = map(string)
  description = "These are the additional tags associated with the main tag of launch template"
  default = {
    Owner       = "Siddharth Gupta"
    Location    = "Noida"
    Create_By   = "Siddharth Gupta"
    Reviewed_By = "Rajat Vats"
  }
}
variable "additional_tags_asg" {
  type        = list(map(string))
  description = "These are the additional tags associated with the main tag of auto scaling group"
  default = [{
    key                 = "Owner"
    value               = "Siddharth Gupta"
    propagate_at_launch = true
    }, {
    key                 = "Location"
    value               = "Noida"
    propagate_at_launch = true
    },
    {
      key                 = "Create_By"
      value               = "Siddharth Gupta"
      propagate_at_launch = true
    },
    {
      key                 = "Reviewed_By"
      value               = "Rajat Vats"
      propagate_at_launch = true
    }
  ]
}

# Variables for Launch Template module

variable "launch_template_name" {
  type        = string
  default     = "docasap_launch_template"
  description = "The default launch template name"
}

variable "iam_instance_profile_arn" {
  type        = string
  default     = ""
  description = "The IAM Instance Profile to launch the instance with"
}

variable "ami_id" {
  type        = string
  default     = "ami-02181e3fc8fd45173"
  description = "The default ami id that user wants to associate with the launch template"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "The default instance type (like micro, medium, large)  that user wants to associate with the launch template"
}

variable "key_name" {
  type        = string
  default     = "sid-key-south-1"
  description = "The default key that user wants to associate with the launch template's instance"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  default     = ["sg-0d500ab4aadfda95a"]
  description = "The default list of security group that the user wants to associate with the launch template"
}

variable "launch_template" {
  type        = string
  default     = ""
  description = "The default launch template id that user wants to associate with the launch template"
}

# Variables Auto Scaling Group module

variable "asg_name" {
  type        = string
  default     = "docasap_asg"
  description = "The default auto-scaling group name"
}

variable "max_size" {
  type        = string
  default     = "2"
  description = "The maximum size of the Auto Scaling Group"
}

variable "min_size" {
  type        = string
  default     = "2"
  description = "The minimum size of the Auto Scaling Group"
}

variable "desired_capacity" {
  type        = string
  default     = "2"
  description = "The number of Amazon EC2 instances that should be running in the group"
}

variable "pvt_subnet_ids" {
  type        = list(string)
  default     = ["subnet-04fc11b60e20beb93", "subnet-028a00b61cec61b9d"]
  description = "The list of subnet ids associated with the auto scaling group"
}

variable "target_group_arn" {
  type    = string
  default = ""
  #default     = "arn:aws:elasticloadbalancing:ap-south-1:869140109150:targetgroup/docasap-alb-tg/501e3bb7956c5a26"
  description = "A aws_alb_target_group ARNs, for use with Application or Network Load Balancing"
}

variable "lt_description" {
  type        = string
  default     = "sample docasap launch template"
  description = "Description of the launch template."
}
```

***output.tf***
```hcl
# Output for Launch Template
output "lt_id" {
  value = module.lt_and_asg.launch_template_id
}

# Output for ASG
output "asg_name" {
  value = module.lt_and_asg.aws_autoscaling_id
}
```



### Variables


| Name  | Description | Type | Default | Required |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: | 
| lt_name  | The name of the launch template  | string  | null  | yes  | 
| lt_description  | Description of the launch template  | string  | null  | yes  |
| user_data  | The Base64-encoded user data to provide when launching the instance  | string  | null  | yes  |
| image_id  | The AMI from which to launch the instance  | string  | not null  | yes  | 
| instance_type  | The type of the instance  | string  | not null  | yes  | yes 
| key_name  | The key name to use for the instance  | string  | null  | yes  | yes
| vpc_security_group_ids  | A list of security group IDs to associate with  | list(string)  | not null  | yes  |
| iam_instance_profile  | The IAM Instance Profile to launch the instance with  | list(map(string))  | null  | yes  |
| target_group_arn  | A aws_alb_target_group ARNs, for use with Application Load Balancing  | string  | null  | yes  |
| lt_tags  | The tag associated with the launch template  | map(string)  | null  | yes  | 
| asg_name  | The name of auto scaling group  | string  | null  | yes  |  
| asg_tags  | The tag associated with auto scaling group | ist(map(string))  | null  | yes  | 
| max_size  | The maximum size of the Auto Scaling Group  | string  | not null  | yes  | 
| min_size  | The minimum size of the Auto Scaling Group  | string  | not null  | yes  | 
| desired_capacity  | The number of Amazon EC2 instances that should be running in the group  | string  | not null  | yes  |
| subnet_ids  | The list of subnet ids associated with the auto scaling group  | list(string)  | not null  | yes  |


### Output


| Name  | Description |
| :-------------: | :-------------: |
| launch_template_id  | Id of launch template  |
| aws_autoscaling_id  | Id of autoscaling group |

### Note:
- **sample folder** is created for referring the values for the main, variable and output terraform files
- **propagate_at_launch** is part of the tag argument, it enables propagation of the tag to Amazon EC2 instances launched via 
  associated ASG, this value should be modified to add suitable tags to ec2 instances
  For Example:
  ````
  {
    key                 = "Owner"
    value               = "Siddharth Gupta"
    propagate_at_launch = true
    }, {
    key                 = "Location"
    value               = "Noida"
    propagate_at_launch = true
    },
    {
      key                 = "Create_By"
      value               = "Siddharth Gupta"
      propagate_at_launch = true
    },
    {
      key                 = "Reviewed_By"
      value               = "Rajat Vats"
      propagate_at_launch = true
    }
  ````