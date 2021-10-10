// VPC creation
resource "aws_vpc" "vpc-tf" {
  cidr_block  = var.cidr-range
  instance_tenancy  = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-tf"
  }
}

// Subnet creation
resource "aws_subnet" "subnets" {
  count = 6
  vpc_id = aws_vpc.vpc-tf.id #select vpc using vpc.id
  cidr_block = cidrsubnet(var.cidr-range,8,count.index) # "cidrsubnet" is function, "8" is bit count will be added to cidr /16, and "count.index" will add count to subnet cidr.
  availability_zone = "${var.region}${count.index%2 == 0?"a":"b"}" # az name will be dynamically writen using region variable and count function and conditional experession.

  tags = {
    "Name" = local.subnets[count.index]
  }
  depends_on = [
    aws_vpc.vpc-tf
  ]
}

// Attaching internet gateway to vpc
resource "aws_internet_gateway" "igw-tf" {
  vpc_id = aws_vpc.vpc-tf.id

  tags = {
    "Name" = local.igw-name
  }
  depends_on = [
    aws_vpc.vpc-tf
  ]
}

// Creation of Route table
resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.vpc-tf.id
  route {
    cidr_block = local.anyware
    gateway_id = aws_internet_gateway.igw-tf.id
}
depends_on = [
  aws_vpc.vpc-tf,
  aws_subnet.subnets[0],
  aws_subnet.subnets[1]
]
tags = {
  "Name" = local.route-table-public
}
}

// route tabel association public
resource "aws_route_table_association" "route-table-association-public" {
  count = 2
  route_table_id = aws_route_table.route-table-public.id
  subnet_id = aws_subnet.subnets[count.index].id

  depends_on = [
    aws_route_table.route-table-public
  ] 
}

/*
// route table association public New approch
resource "aws_route_table_association" "route-table-association-public" {
  for_each = data.aws_subnet_ids.subnet-public.ids
  route_table_id = aws_route_table.route-table-public.id
  subnet_id = each.key

  depends_on = [
    aws_route_table.route-table-public,
    aws_vpc.vpc-tf,
    aws_subnet.subnets[0],
    aws_subnet.subnets[1]

  ]
  
}
*/


// route table private
resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.vpc-tf.id

  depends_on = [
    aws_vpc.vpc-tf,
    aws_subnet.subnets[2],
    aws_subnet.subnets[3],
    aws_subnet.subnets[4],
    aws_subnet.subnets[5],

  ]
  tags = {
    "Name" = local.route-table-private
  } 
}
 

// route table assocaiation private
resource "aws_route_table_association" "route-table-association-private" {
  count = 4
  route_table_id = aws_route_table.route-table-private.id
  subnet_id = aws_subnet.subnets[count.index+2].id

  depends_on = [
    aws_route_table.route-table-private
  ]
}

/*
// route table association private New approch
resource "aws_route_table_association" "route-table-association-private" {
  for_each = data.aws_subnet_ids.subnet-private.ids
  route_table_id = aws_route_table.route-table-private.id
  subnet_id = each.key

  depends_on = [
    aws_route_table.route-table-private,
    aws_vpc.vpc-tf,
    aws_subnet.subnets[2],
    aws_subnet.subnets[3],
    aws_subnet.subnets[4],
    aws_subnet.subnets[5],

  ]
  
}
*/