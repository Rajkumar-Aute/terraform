// VPC creation
resource "aws_vpc" "vpc-tf" {
  cidr_block  = var.cidr_range
  instance_tenancy  = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-tf"
  }
}

// Subnet creation
resource "aws_subnet" "subnet" {
  count = 6
  vpc_id = aws_vpc.vpc-tf.id #select vpc using vpc.id
  cidr_block = cidrsubnet(var.cidr_range,8,count.index) # "cidrsubnet" is function, "8" is bit count will be added to cidr /16, and "count.index" will add count to subnet cidr.
  availability_zone = "${var.region}${count.index%2 == 0?"a":"b"}" # az name will be dynamically writen using region variable and count function and conditional experession.

  tags = {
    "Name" = local.subnets[count.index]
  }
  depends_on = [
    aws_vpc.vpc-tf
  ]
}

// Attaching internet gateway to vpc
resource "aws_internet_gateway" "igw_tf" {
  vpc_id = aws_vpc.vpc-tf.id

  tags = {
    "Name" = local.igw_name
  }
  depends_on = [
    aws_vpc.vpc-tf
  ]
}

// Creation of Route table
resource "aws_route_table" "rt-tf" {
  vpc_id = aws_vpc.vpc-tf.id
  route {
    cidr_block = local.anyware
    gateway_id = aws_internet_gateway.igw_tf.id
}
depends_on = [
  aws_vpc.vpc-tf,
  aws_subnet.subnet[0],
  aws_subnet.subnet[1]
]
}

// route tabel association
resource "aws_route_table_association" "web-rt" {
  count = 2
  route_table_id = aws_route_table.rt-tf.id
  subnet_id = aws_subnet.subnet[count.index].id

  depends_on = [
    aws_route_table.rt-tf
  ]
  
}


