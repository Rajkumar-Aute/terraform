
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
      values = [local.subnets[2], local.subnets[3], local.subnets[4], local.subnets[5],]
    }
  
}


/* if you get below error run with #terraform apply -target="aws_subnet.subnets" 
it will create the dependancey first.
│ Error: Invalid for_each argument
│
│   on main.tf line 70, in resource "aws_route_table_association" "route-table-association-public":
│   70:   for_each = data.aws_subnet_ids.subnet-public.ids
│     ├────────────────
│     │ data.aws_subnet_ids.subnet-public.ids is a set of string, known only after apply
│
│ The "for_each" value depends on resource attributes that cannot be
│ determined until apply, so Terraform cannot predict how many instances will
│ be created. To work around this, use the -target argument to first apply
│ only the resources that the for_each depends on.
 */