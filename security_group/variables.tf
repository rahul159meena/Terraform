variable "sg_name" {
  description = "Give the name of your SecurityGroup"
  type        = string
}

variable "vpc_id" {
  description = "Give your VPC Id for Security Group"
  type        = string
}

variable "sg_ingress" {
  description = "List of Ingerss Ports and CIDRs"
  type        =  list 
}

variable "sg_egress" {
  description = "Egress Ports and CIDRs"
  type        = list
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Extra tags to attach to the VPC resources"
}

variable "sg_name_tag" {
  description = "Name of environment this VPC is targeting"
  type        = string
}

