# AWS Security Group

## This module will create a Load Balancer along side a variety of related information:
 - Security Group with Ingress
 - Security Group with Egress

### Usage
***main.tf***
```hcl
module "security_group" {
  source = "../modules/security_group/"
  sg_name = var.sg_name
  vpc_id  = var.vpc_ID
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
```

***variables.tf***
```hcl
#Variables for Security Group
variable "sg_name" {
  description = "Name of your Security Group"
  type        = string
  default     = "da-test-sg"
}
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| sg_name  |  Give the name of your SecurityGroup  | string  | null  | yes  | 
| vpc_id  | Give your VPC Id for Security Group  |  string  | true  | yes  |
| sg_ingress  |  List of Ingerss Ports and CIDRs  | list(string)  | not null  | yes  |
| sg_egress  |  Egress Ports and CIDRs  |  list(string)  | not null  | yes  | 
| sg_name_tag  |  Do you want to enable delete protection  | bool  |  false  | yes  |
| tags |  Extra tags to attach to the VPC resources |  map(string)  | null  | yes  |


### Output


| Name | Description |
| :-----: | :-----------: |
| sg_id | Security group ID |


