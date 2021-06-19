# AWS modules using Terraform

## This Terraform repository contains several module which will creates the variety of resources: 
 - VPC
 - Security Group
 - Application Load Balancer 
    - Access log enabled in S3 bucket
    - ALB Listeners
 - Listeners
 - TargetGroup 
 - TargetGroup Attachment
 - Launch Template
 - Auto Scaling Group

### Example Usage
***provider.tf***
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
```

***main.tf***
```hcl
module "vpc" {
  source               = "github"
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "security_group" {
  source = ""
  sg_name = var.sg_name
  vpc_id  = var.vpc_id
  sg_ingress = [
    {
      description     = "For HTTPS request at port 443"
      from_port        = 443
      to_port          = 443
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = false
      security_groups = []
    },
    {
      description     = "For HTTP request at port 80"
      from_port        = 80
      to_port          = 80
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = true
      security_groups = []
    },
    {
      description     = "For SSH request at port 22"
      from_port        = 22
      to_port          = 22
      protocol        = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self            = false
      security_groups = []
    }
  ]

  sg_egress = [
    {
      description     = ""
      from_port        = 0
      to_port          = 0
      protocol        = -1
      cidr_blocks      = ["0.0.0.0/0"]
      self            = false
      security_groups = []
    }
  ]
    sg_name_tag = "securitygroup"
}

module "alb_and_alb_listeners" {
  source                                 = ""
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
  prefix				                         = var.prefix
  target_grooup_arn                      = var.target_group_arn
  listener_details                       = var.listener_details
}

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
  asg_name         = var.asg_name
  max_size         = var.max_size
  min_size         = var.min_size
  desired_capacity = var.desired_capacity
  subnet_ids       = var.pvt_subnet_ids
  asg_tags         = var.additional_tags_asg
  target_group_arn = var.target_group_arn
}
```

***variables.tf***
```hcl
# Variable for VPC
variable "cidr_block" 
{
    description = "The CIDR Block for VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "instance_tenancy"
{
    description = "A tenancy option for instances launched into the VPC"
    type        =  string
    default     = "default"
}

variable "enable_dns_support"
{
    description = "A boolean flag to enable/disable DNS support in the VPC"
    type        = bool
    default     = true
}

variable "enable_dns_hostnames"
{
    description = "A boolean flag to enable/disable DNS hostnames in the VPC"
    type        = bool
    default     = true
}

variable "name"
{
    description = "The name for the VPC"
    type        = string
    default     = "da-vpc"
}

variable "tags"
{
    description = "A mapping of tags to assign to all resources"
    type        = map(string)
    default     = {}
}

#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "da-test-sg"
}

variable "vpc_id" {
  description = "Give your vpc id here"
  type        = string
  default     = "vpc-0391267e62cf0cff1"
}

variable "sg_name_tag" {
  description = "Tag name for your Security Group"
  type        = string
  default     = "tf-sg"
}

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



### Variables
| Name                        |  Description                                                                                                         | Type     | Default | Required |
| :-------------------------: | :------------------------------------------------------------------------------------------------------------------: | :------: |  :----:  | :------: | 
| cidr_block                  | The CIDR block for the VPC                                                                                           | `string` | 10.0.0.0/16                            | Yes |
| instance_tenancy            | A tenancy option for instances launched into the VPC options are (default, dedicated or host)                        | `string` | default                                | optional |
| enable_dns_support          | A boolean flag to enable/disable DNS support in the VPC                                                              | `bool` | true                                   | optional |
| enable_dns_hostnames        | A boolean flag to enable/disable DNS hostnames in the VPC                                                            | `bool` | false                                  | optional |
| name                        | The name for the VPC                                                                                                 | `string` | null                                   | optional |
| alb_name                    |  Name of Load Balancer                                                                                               | `string`  | auto-generate name starts with tf-alb  | yes  | 
| internal_alb                | If internal true then LB will be internal                                                                            | `bool`  | false                                  | yes  |
| alb_security_groups_ids     |  Security groups to be associated with ALB                                                                           | `list(string)`  | not null                          | yes  |
| subnets_id                  |  A list of subnet IDs to attach to the LB                                                                            | `list(string)` | not null                           | yes  | 
| enable_deletion_protection  |  Do you want to enable delete protection                                                                             | `bool`  |  false                                  | yes  |
| alb_tags                    |  A map of tags to add to all resources                                                                               | `map(string)`  | null                              | yes  |
| alb_log_bucket              |  Name of S3 bucket where log will store                                                                              | `string` | not null                               | yes  |
| prefix                      | The S3 bucket prefix Logs are stored in the root if not configured                                                   | `string` | null                                   | yes |
| alb_enable_logging          |  Do you want logging enable: true for yes                                                                            |  `bool`  | false                                  | yes  |
| target_group_arn            | This is Target Group arn                                                                                             |  `string`  | not null                               | yes  |
| certificate_arn             |  Provide SSL certificate arn                                                                                         | `string`  |  null                                   | yes  |
| listener_details            |  List of some Listener details here                                                                                  |  `map(any)`  |  null                                | yes  | 
| forward_port                |  Port number to forward request                                                                                      | `number`  |  null                                   | yes  |
| ssl_policy                  |  SSL policy for HTTPS request                                                                                        |  `string`  | null                                   | yes  |
| drop_invalid_header_fields  | Indicates whether invalid header fields are dropped in application load balancers. Defaults to false                 | `bool` |  false                                  | yes | 
| idle_timeout                | The time in seconds that the connection is allowed to be idle                                                        | `number` | 60                                     | yes |
| target_group_details        |  Some essential details of TargetGroup                                                                               | `map(any)`  | not null                             | yes  | 
| vpc_id                      | VPC ID for your TargetGroup                                                                                          |  `string`  | null                                   | yes  |
| healthy_threshold           | Number of consecutive health checks successes required before considering an unhealthy target healthy                | `number`  |  3                                      | yes  |
| unhealthy_threshold         |  Number of consecutive health check failures required before considering the target unhealthy                        |  `number`  |  3                                   | yes  | 
| timeout                     |  Amount of time, in seconds, during which no response means a failed health check                                    | `number`  |  5                                      | yes  |
| interval                    |  Approximate amount of time, in seconds, between health checks of an individual target                               |  `string`  | 5                                      | yes  |
| health_check_path           |  Path to health-check                                                                                                |  `string`  | /                                      | yes |
| health_check_port           | Port to health-check                                                                                                 | `number` | 80                                     | yes |
| target_ids                  | Give target_ids which you want to register with your TG                                                              |  `string`  | null                                   | yes  |
| port                        |  Port on which instance will get registered in Target group                                                          | `number`  |  null                                   | yes  |
| deregistration_delay        |  Amount time for Load Balancing to wait before changing the state of a deregistering target from draining to unused  | `number` | 300                                    | yes  |
| slow_start                  | Amount time for targets to warm up before the load balancer sends them a full share of requests                      | `number` | 0                                      | yes |
| target_ids                  | This is the TargetID where Target Group will attach                                                                  | `list(string)` | not null                           | yes |
| port                        | Port on which instance will get registered in Target group                                                           | `number` | 80                                     | yes |
| lt_name                     | The name of the launch template                                                                                      | `string`  | null                                   | yes  | 
| lt_description              | Description of the launch template                                                                                   | `string`  | null                                   | yes  |
| user_data                   | The Base64-encoded user data to provide when launching the instance                                                  | `string`  | null                                   | yes  |
| image_id                    | The AMI from which to launch the instance                                                                            | `string`  | not null                               | yes  | 
| instance_type               | The type of the instance                                                                                             | `string`  | not null                               | yes  |
| key_name                    | The key name to use for the instance                                                                                 | `string`  | null                                   | yes  |
| vpc_security_group_ids      | A list of security group IDs to associate with                                                                       | `list(string)`  | not null                          | yes  |
| iam_instance_profile        | The IAM Instance Profile to launch the instance with                                                                 | `list(map(string))`  | null                     | yes  |
| target_group_arn            | A aws_alb_target_group ARNs, for use with Application Load Balancing                                                 | `string`  | null                                   | yes  |
| lt_tags                     | The tag associated with the launch template                                                                          | `map(string)`  | null                              | yes  | 
| asg_name                    | The name of auto scaling group                                                                                       | `string`  | null                                   | yes  |  
| asg_tags                    | The tag associated with auto scaling group                                                                           | `list(map(string))`  | null                     | yes  | 
| max_size                    | The maximum size of the Auto Scaling Group                                                                           | `string`  | not null                               | yes  | 
| min_size                    | The minimum size of the Auto Scaling Group                                                                           | `string`  | not null                               | yes  | 
| desired_capacity            | The number of Amazon EC2 instances that should be running in the group                                               | `string`  | not null                               | yes  |
| subnet_ids                  | The list of subnet ids associated with the auto scaling group                                                        | `list(string)`| not null                            | yes  |





### Output


| Name                          | Description                                                                                  |
| :---------------------------: | :------------------------------------------------------------------------------------------: |
| vpc_arn                       | Amazon Resource Name (ARN) of VPC                                                         |
| vpc_id                        | The ID of the VPC                                                                         |
| vpc_cidr_block                | The CIDR block of the VPC                                                                 |
| vpc_instance_tenancy          | Tenancy of instances spin up within VPC                                                   |
| vpc_enable_dns_support        | Whether or not the VPC has DNS support                                                    |
| vpc_enable_dns_hostnames      | Whether or not the VPC has DNS hostname support                                           |
| vpc_main_route_table_id       | The ID of the main route table associated with this VPC                                   |
| vpc_default_network_acl_id    | The ID of the network ACL created by default on VPC creation                              |
| vpc_default_security_group_id | The ID of the security group created by default on VPC creation                           |
| vpc_default_route_table_id    | The ID of the route table created by default on VPC creation                              |
| alb_arn                       | This will be ALB arn                                                                      |
| alb_id                        | ID of the ALB                                                                             |
| alb_dns                       | The DNS name of the ALB                                                                   |
| alb_zoneid                    | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |
| alb_forward_listener_arn      | This is alb_listener Arn                                                                  |
| listener_rule_pattern_arn     | Arn's associated with the listener rules created                                          |
| launch_template_id            | Id of launch template                                                                     |
| aws_autoscaling_id            | Id of autoscaling group                                                                   |


### Note 
- If you are using `forward_protocol = HTTPS` then you have to provide `certificate_arn` and `ssl_policy`
- The listener rules can be any of the below:
    - Path based routing
    - Host based routing
    - Http Header based 
    - Query String based
 - The user can either provide any empty list (like []) or provide associated values 

 - Please find a sample snap of the listener rules created by the above sample module
 - **sample folder** is created for referring the values for the main, variable and output terraform files
  - **propagate_at_launch** is part of the tag argument, it enables propagation of the tag to Amazon EC2 instances launched via 
  associated ASG, this value should be modified to add suitable tags to ec2 instances
  For Example:
  ````
  {
    key                 = "Owner"
    value               = "XYZ"
    propagate_at_launch = true
    }, {
    key                 = "Location"
    value               = "City"
    propagate_at_launch = true
    },
    {
      key                 = "Create_By"
      value               = "XYZ"
      propagate_at_launch = true
    },
    {
      key                 = "Reviewed_By"
      value               = "ABC"
      propagate_at_launch = true
    }
  }
  ````