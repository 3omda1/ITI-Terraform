# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"

}
# resource "aws_subnet" "public-1" {
#   vpc_id = var.id_vpc      
#   cidr_block = var.sub-public1-cidr

# }

resource "aws_subnet" "public-1" {
  count      = length(var.private-subnet)
  vpc_id     = var.vpc-id
  cidr_block = var.private-subnet[count.index]

  tags = {
    Name = "${var.puplic-subnet-tag}"

  }
}




