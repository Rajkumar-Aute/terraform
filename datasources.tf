/*
// datasourch to fetch subnet ids
data "aws_subnet_ids" "subnet-public" {
    vpc_id = aws_vpc.vpc-tf.id
    filter {
      name = "tag:Name"
      values = [local.subnets[0], local.subnets[1]]
    }
  
}


data "aws_subnet_ids" "subnet-private" {
    vpc_id = aws_vpc.vpc-tf.id
    filter {
      name = "tag:Name"
      values = [local.subnets[2], local.subnets[3], local.subnets[4], local.subnets[5]]
    }
  
}

*/