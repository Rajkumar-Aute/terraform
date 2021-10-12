/* 
locals variables used to add Variables in the local.
This local variable cannot paramaterized
Cannot be changed with "-var" while running terraform apply command 

workspace strings has been added we can create different env using workspace
# terraform workspace list // it will list the workspacess
# terraform workspace new <workspace-name / env-name> //it will create new workspace
# terraform workspace select <workspace-name>  // it will select / change the workspace
 */

locals {
  subnets                = ["web-sub1-${terraform.workspace}", "web-sub2-${terraform.workspace}", "app-sub1-${terraform.workspace}", "app-sub2-${terraform.workspace}", "db-sub1-${terraform.workspace}", "db-sub2-${terraform.workspace}"]
  igw-name               = "igw-${terraform.workspace}"
  anyware                = "0.0.0.0/0"
  route-table-public     = "rt-pub-${terraform.workspace}"
  route-table-private    = "rt-pri-${terraform.workspace}"
  securitygroup-name-web = "security-group-web-${terraform.workspace}"
  securitygroup-name-app = "security-group-app-${terraform.workspace}"
  securitygroup-name-db  = "security-group-db-${terraform.workspace}"
  ssh                    = 22
  http                   = 80
  tcp                    = "tcp"
  dbport                 = "3306"


  // locals for RDS
  db-subnet-group-name = "db-subnet-${terraform.workspace}"
  db-rds-name          = "rds-${terraform.workspace}"
  db-name              = "mysql${terraform.workspace}"
  rds-instance-type    = "db.t2.micro"
  rds-username         = "user"
  rds-password         = "Welcome12345"

  // lodals for ec2
  ec2-web-server-name = "ec2-web-server-${terraform.workspace}"
  ec2-ssh-key         = "terraform"
}