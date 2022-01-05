resource "aws_subnet" "Ahmed-puplic-subnet1" {
  vpc_id            = data.aws_vpc.task3VPC.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "This is the main subnet"
  }
}