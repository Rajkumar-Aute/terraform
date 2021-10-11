// Variables for terraform filesresource
// Variables can be paramatirized.

// variable for Region, this can be changed while running terraform apply -var "region=<required_region>"
variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Selected Mumbai region"
}

// Variable for CIDR range, this can be changed while running terraform apply -var "cidr_range=<required_iprange>"
variable "cidr-range" {
  type        = string
  default     = "10.10.0.0/16"
  description = "VPC CIDR range"
}

// variable for instance type
variable "ec2-instance-type" {
  type        = string
  default     = "t2.micro"
  description = "ec2 instance type"
}

