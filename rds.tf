// creation of DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
    name = local.db-subnet-group-name
    subnet_ids = [aws_subnet.subnets[4].id, aws_subnet.subnets[5].id]

    tags = {
      "Name" = local.db-subnet-group-name
    }
    depends_on = [
      aws_subnet.subnets[4],
      aws_subnet.subnets[5]
    ]
  
}
