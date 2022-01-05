terraform {
 backend "s3" {
 bucket = "iti-terraform-workspace"
 key = "terraform.tfstate"
 region = "eu-west-1"
 }
}


