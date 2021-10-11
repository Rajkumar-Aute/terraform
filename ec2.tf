// creation of ec2 instances
resource "aws_instance" "ec2-tf" {
    ami = data.aws_ami.ubuntu.id
    associate_public_ip_address = true
    instance_type = var.ec2-instance-type
    key_name = local.ec2-ssh-key
    vpc_security_group_ids = [aws_security_group.security-group-web.id]
    subnet_id = aws_subnet.subnets[0].id
    
    tags = {
      "Name" = "webserver"
    }
}