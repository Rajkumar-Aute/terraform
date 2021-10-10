# locals variables used to add Variables in the local.
# This local variable cannot paramaterized
# Cannot be changed with "-var" while running terraform apply command 

locals {
  subnets = ["sub1","sub2","sub3","sub4","sub5","sub6"]
  igw_name = "igw_tf"
}