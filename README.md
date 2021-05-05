# Application Load Balancer with Listeners and TargetGroup

## This module will create a Load Balancer along side a variety of related resources, including: 
 - Security Group
 - Application Load Balancer 
 - Listeners
 - TargetGroup 
 - TargetGroup Attachment

### Example Usage
***main.tf***
```hcl
module "security_group" {
  source = "/modules/security_group"
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

module "alb" {
  source                     = "/modules/alb/"
  alb_name                   = var.alb_name
  internal                   = var.internal
  alb_security_groups_ids    = module.security_group.sg_id
  subnets_id                 = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection
  lb_tags                    = var.alb_tags_map
}

module "target_group" {
  source               = "/modules/target_group/"
  target_group_details = var.tg_details
  vpc_id               = var.vpc_id
}

module "tg_attachment" {
  source    = "/modules/target_group_attachment/"
  count     = length(var.targetid)
  target_id = var.target_id[count.index]
  tg_arn    = module.target_group.tg_arn
  port      = 80
}

module "alb_listener" {
  source            = "/modules/albListner/"
  lb_arn            = module.alb.alb_arn
  tg_arn            = module.target_group.tg_arn
  listener_details  = var.listener_details
  certificat_earn   = var.listener_details["forward_protocol"] == "HTTP" ? null : var.certificate_arn
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

variable "internal" {
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

#Variables for TargetGroup
variable "tg_details" {
  default = {
    tg_name     = "test-TG"
    tg_port     = 80
    tg_protocol = "HTTP"
    target_type = "instance"
  }
}

variable "vpc_id" {
  default = "vpc-0391267e62cf0cff1"
}

#Variable for TargetGroup attachment
variable "target_id" {
  description = "This is the TargetID where TG will attach"
  type        = list(string)
  default     = ["i-069894aabebcd6b23", "i-08ed634a42bc9859a"]
}

variable "healthy_threshold" {
  description = "Number of healthy thresold you want"
  type        = number
  default     = 10
}

variable "unhealthy_threshold" {
  description = "Number of Un-healthy thresold you want"
  type        = number
  default     = 10
}

variable "timeout" {
  description = "Give timeout duration"
  type        = number
  default     = 3
}

variable "interval" {
  description = "Interval"
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

#Variables for ALB Listeners
variable "listener_details" {
  default = {
    forward_port     = 80
    forward_protocol = "HTTP"
    ssl_policy       = ""
  }
}

variable "certificate_arn" {
  description = "Provide your Certificate arn here"
  type        = string
  default     = ""
}

#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "test-sg"
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
| lb_arn  |  This is Load Balancer arn  | string  | null  | yes  | 
| tg_arn  | This is Target Group arn  |  string  | null  | yes  |
| certificate_arn  |  Provide SSL certificate arn  | string  |  null  | yes  |
| listener_details  |  List of some Listener details here  |  map(any)  |  null  | yes  | 
| forward_port  |  Port number to forward request  | number  |  null  | yes  |
| ssl_policy  |  SSL policy for HTTPS request  |  string  | null  | yes  |
| target_group_details  |  Some essential details of TargetGroup  | map(any)  | null  | yes  | 
| vpc_id  | VPC ID for your TargetGroup  |  string  | null  | yes  |
| healthy_threshold  |  Number of healthy thresold you want  | number  |  null  | yes  |
| unhealthy_threshold  |  Number of un-healthy thresold you want  |  number  |  null  | yes  | 
| timeout  |  Give timeout duration  | number  |  null  | yes  |
| interval  |  SSL policy for HTTPS request  |  string  | null  | yes  |
| health_check_path |  Path to health-check  |  string  | null | yes |
| health_check_port | Port to health-check | number | null | yes |
| tg_arn  |  Provide Target Group arn  | string  | null  | yes  | 
| target_id  | Give targetid which you want to register with your TG  |  string  | null  | yes  |
| port  |  Port on which instance will get registered in Target group  | number  |  null  | yes  |





### Output


| Name | Description |
| :-----: | :-----------: |
| alb_arn | This will be ALB arn |
| alb_id | ID of the ALB |
| alb_dns | The DNS name of the ALB |
| alb_zoneid | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record) |
| alb_forward_listener_arn | This is alb_listener Arn |
| tg_arn | This is TargetGroup arn |
| tg_arn | This is TargetGroup arn |
