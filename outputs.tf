// information output about below resources
output "vpcid" {
    value = aws_vpc.vpc-tf.id 
}

output "web-server-id" {
    value = aws_instance.ec2-web-tf.id
}

output "web-server-ip" {
    value = aws_instance.ec2-web-tf.public_ip
}

output "php-url" {
    value = format("http://%s/info.php",aws_instance.ec2-web-tf.public_ip) 
}