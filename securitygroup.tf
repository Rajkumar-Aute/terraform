// creating web security group
resource "aws_security_group" "security-group-web" {
  name        = local.securitygroup-name-web
  description = "allow port 22, 80, 443"
  vpc_id      = aws_vpc.vpc-tf.id

  ingress {
    cidr_blocks = [local.anyware]
    description = "open 22"
    from_port   = local.ssh
    protocol    = local.tcp
    to_port     = local.ssh
  }

  ingress {
    cidr_blocks = [local.anyware]
    description = "open 80"
    from_port   = local.http
    protocol    = local.tcp
    to_port     = local.http
  }

  egress {
    cidr_blocks = [local.anyware]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags = {
    "Name" = local.securitygroup-name-web
    "env"  = terraform.workspace
  }

  depends_on = [
    aws_route_table.route-table-public,
    aws_route_table.route-table-private
  ]
}

// creating app security group

resource "aws_security_group" "security-group-app" {
  name        = local.securitygroup-name-app
  vpc_id      = aws_vpc.vpc-tf.id
  description = "security group for app"

  ingress {
    cidr_blocks = [aws_vpc.vpc-tf.cidr_block]
    description = "open 80"
    from_port   = local.http
    to_port     = local.http
    protocol    = local.tcp
  }

  egress {
    cidr_blocks = [local.anyware]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  depends_on = [
    aws_route_table.route-table-private,
    aws_route_table.route-table-public
  ]

  tags = {
    "Name" = local.securitygroup-name-app
    "env"  = terraform.workspace
  }


}

// creating rds security group
resource "aws_security_group" "security-group-db" {
  name        = local.securitygroup-name-db
  vpc_id      = aws_vpc.vpc-tf.id
  description = "security group for db"

  ingress {
    cidr_blocks = [aws_vpc.vpc-tf.cidr_block]
    description = "open 3306"
    from_port   = local.dbport
    to_port     = local.dbport
    protocol    = local.tcp
  }

  egress {
    cidr_blocks = [local.anyware]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  depends_on = [
    aws_route_table.route-table-private,
    aws_route_table.route-table-public
  ]

  tags = {
    "Name" = local.securitygroup-name-db
    "env"  = terraform.workspace
  }
}