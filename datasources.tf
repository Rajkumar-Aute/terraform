// datasourch to fetch subnet ids
data "aws_subnet_ids" "subnet-public" {
    vpc_id = aws_vpc.vpc-tf.id
    filter {
      name = "tag:Name"
      values = [local.subnets[0], local.subnets[1]]
    }
  
}