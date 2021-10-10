// creating web security group
resource "aws_security_group" "security-group-web" {
    name = local.securitygroup-name-web
    description = "allow port 22, 80, 443"
    vpc_id = aws_vpc.vpc-tf.id

    ingress  {
      cidr_blocks = [ local.anyware ]
      description = "open 22"
      from_port = local.ssh
      protocol = local.tcp
      to_port = local.ssh
    } 
    
    ingress  {
      cidr_blocks = [ local.anyware ]
      description = "open 80"
      from_port = local.http
      protocol = local.tcp
      to_port = local.http
    } 
    
    tags = {
      "Name" = local.securitygroup-name-web
    }
  
    depends_on = [
      aws_route_table.route-table-public, 
      aws_route_table.route-table-private
    ]
}