// Cloud Provider information
provider "aws" {
    region = var.region
    shared_credentials_file = "/Users/raj/.aws/credentials"
    profile                 = "terraform"
}