# Variables for terraform filesresource 

variable "region" {
    type = string
    default = "ap-south-1"
    description = "Selected Mumbai region"
  
}

variable "cidr_range" {
    type = string
    default = "10.10.0.0/16"
    description = "VPC CIDR range"
  
}

variable "subnets" {
    type = list(string)
    default = [ "sub1","sub2","sub3","sub4","sub5","sub6", ]
    description = "subnet names"
}









# It will help us to get Account ID and User details.
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}