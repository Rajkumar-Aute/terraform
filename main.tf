
# VPC creation
resource "aws_vpc" "vpc-tf" {
  cidr_block  = var.cidr_range
  instance_tenancy  = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-tf"
  }
}

# Subnet creation

resource "aws_subnet" "subnet1-tf" {
  vpc_id = aws_vpc.vpc-tf.id
  cidr_block = "10.10.1.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    "Name" = "subnet1-tf"
  }
  
}












