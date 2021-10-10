# Variables for terraform filesresource
# Variables can be paramatirized.



# variable for Region, this can be changed while running terraform apply -var "region=<required_region>"
variable "region" {
    type = string
    default = "ap-south-1"
    description = "Selected Mumbai region"
  
}


# Variable for CIDR range, this can be changed while running terraform apply -var "cidr_range=<required_iprange>"
variable "cidr_range" {
    type = string
    default = "10.10.0.0/16"
    description = "VPC CIDR range"
  
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