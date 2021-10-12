// creation of ec2 instances
resource "aws_instance" "ec2-web-tf" {
  ami                         = data.aws_ami.ubuntu.id
  associate_public_ip_address = true
  instance_type               = var.ec2-instance-type
  key_name                    = local.ec2-ssh-key
  vpc_security_group_ids      = [aws_security_group.security-group-web.id]
  subnet_id                   = aws_subnet.subnets[0].id

  tags = {
    "Name" = "local.ec2-web-server-name-${terraform.workspace}"
    "env" = terraform.workspace
  }

  depends_on = [
    aws_db_instance.rds-tf
  ]
}

// null resource and provisioner is add to run the script at the time of creating the resources

resource "null_resource" "null-provisionining" {

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/raj/terraform.pem") // provide the ssh key path by creating from AWS Console
    host        = aws_instance.ec2-web-tf.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo apt update", 
        "sudo apt install apache2 php libapache2-mod-php php-mysql php-cli -y",
        "echo '<?php phpinfo(); ?>'| sudo tee /var/www/html/info.php"
        ]
  }
}