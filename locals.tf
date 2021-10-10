/* 
locals variables used to add Variables in the local.
This local variable cannot paramaterized
Cannot be changed with "-var" while running terraform apply command 
*/

locals {
  subnets = ["web-sub1","web-sub2","app-sub1","app-sub2","db-sub1","db-sub2"]
  igw-name = "igw_tf"
  anyware = "0.0.0.0/0"
  route-table-public = "rt-pub-tf"
  route-table-private = "rt-pri-tf"
  securitygroup-name-web = "security-group-web"
  securitygroup-name-app    =   "security-group-app"
  ssh = 22
  http = 80
  tcp = "tcp"
}