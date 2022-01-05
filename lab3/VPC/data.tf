data "aws_vpc" "task3VPC" {
  filter {
    name   = "tag:Name"
    values = ["This is the main VPC"]
  }
}

# data "aws_security_groups" "task3SK" {
#   filter {
#     name   = "tag:Name"
#     values = ["This is the main security group"]
#   }
# }

# data "aws_subnet" "task3subnet" {
#   filter {
#     name   = "tag:Name"
#     values = ["This is the main subnet"]
#   }
# }




