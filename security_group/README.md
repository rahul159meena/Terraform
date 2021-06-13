# AWS Security Group

## This module will create a Load Balancer along side a variety of related information:
 - Security Group with Ingress
 - Security Group with Egress

### Usage
***main.tf***
```hcl
module "security_group" {
  source      = ""
  sg_name     = var.sg_name
  vpc_id      = var.vpc_id
  sg_name_tag = var.sg_name_tag
  sg_ingress  = [
    {
      description      = "For HTTPS request at port 443"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self             = false
      security_groups  = []
    },
    {
      description      = "For HTTP request at port 80"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self             = true
      security_groups  = []
    },
    {
      description      = "For SSH request at port 22"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["10.0.0.0/24"]
      self             = false
      security_groups  = []
    }
  ]

  sg_egress = [
    {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      self             = false
      security_groups  = []
    }
  ]
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
```

### Variables


| Name  |  Description  | Type | Default | Required |
| :-------------:  | :-------------: | :-------------: |  :-----------:  | :-------------: | 
| sg_name  |  Give the name of your SecurityGroup  | string  | tf-sg  | yes  | 
| vpc_id  | Give your VPC Id for Security Group  |  string  | null  | yes  |
| sg_name_tag | Tag name for your Security Group | string | tf-sg | yes |
| sg_ingress  |  List of Ingerss Ports and CIDRs  | list(object)  | not null  | yes  |
| sg_egress  |  Egress Ports and CIDRs  |  list(object)  | not null  | yes  |
| description | This is the description about your rule | string | Managed by Terraform | yes |
| from_port | Port number for start port range | number | 0 | yes |
| to_port | Port number to end port range | number | 0 | yes |
| protocol | Name of protocol you want to use | string | tcp | yes |
| cidr_blocks | List of CIDR blocks | list(string) | not null | yes |
| self | Whether the security group itself will be added as a source to this rule | bool | false | yes |
| security_groups | List of security group Group Names if using EC2-Classic, or Group IDs if using a VPC | list(string) | null | yes |


### Output


| Name | Description |
| :-----: | :-----------: |
| sg_id | Security group ID |
