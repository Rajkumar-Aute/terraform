// creation of DB subnet group
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = local.db-subnet-group-name
  subnet_ids = [aws_subnet.subnets[4].id, aws_subnet.subnets[5].id]

  tags = {
    "Name" = local.db-subnet-group-name
    "env"  = terraform.workspace
  }
  depends_on = [
    aws_subnet.subnets[4],
    aws_subnet.subnets[5]
  ]

}

// creation of RDS Instance
resource "aws_db_instance" "rds-tf" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = local.rds-instance-type
  name                   = local.db-name
  username               = local.rds-username
  password               = local.rds-password
  identifier             = local.db-name
  skip_final_snapshot    = "true"
  db_subnet_group_name   = local.db-subnet-group-name
  vpc_security_group_ids = [aws_security_group.security-group-db.id]

  depends_on = [
    aws_db_subnet_group.db-subnet-group
  ]

  tags = {
    "Name" = local.db-rds-name
    "env"  = terraform.workspace
  }
}