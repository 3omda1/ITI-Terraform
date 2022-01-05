

# creating a VPC
resource "aws_vpc" "Ahmed-VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "This is the main VPC"
  }
}