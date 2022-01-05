# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"

}

resource "aws_vpc" "Ahmed-VPC" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = "${var.vpc-tag}"
  }
}