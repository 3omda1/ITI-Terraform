# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"

}

resource "aws_instance" "AhmedEC2" {
  count         = lower(var.create-ec2 ? 1 : 0)
  ami           = var.ami-name
  instance_type = var.instance-type-name
  subnet_id     = var.subnet-id

  tags = {
    Name = upper("HelloWorld by Ahmed Emad")
  }
}
