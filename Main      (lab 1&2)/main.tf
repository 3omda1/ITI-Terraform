#----------------------------------------------------------------
# lab1


# Configure the AWS Provider
provider "aws" {
  region     = "eu-west-1"
  
}

# #creating a VPC

# resource "aws_vpc" "AhmedVPC" {
#   cidr_block       =  "${var.VPC-cidr_block}"
#   #var.VPC-cidr_block
#   tags = {
#     Name = var.VPC-tag-name
#   }
# }

# #craeting a subnet1

# resource "aws_subnet" "AhmedSubnet1" {
#   vpc_id            = aws_vpc.AhmedVPC.id
#   cidr_block        = var.subnets-cidr[0]
#   availability_zone = "eu-west-1a"

#   tags = {
#     Name = var.subnet1-tag-name
#   }
# }

# #craeting a subnet2

# resource "aws_subnet" "AhmedSubnet2" {
#   vpc_id            = aws_vpc.AhmedVPC.id
#   cidr_block        = var.subnets-cidr[1]
#   availability_zone = "eu-west-1a"

#   tags = {
#     Name = "${var.subnet2-tag-name} --- ${var.subnet2-another-way}"
#   }
# }


# #variables here


# variable "VPC-cidr_block" {
#  description = "this is the VPC cidr_block variable "
#  type = string
# }

# variable "VPC-tag-name" {
#  description = "this is the VPC variable that will be used"
#  default = "ITI VPC"
#  type = string
# }

# variable "subnet1-tag-name" {
#  description = "this is the subnet1-tag-name variable that will be used"
#  default = "ITI subnet1"
#  type = string
# }

# variable "subnet2-tag-name" {
#  description = "this is the subnet2-tag-name variable that will be used"
#  default = "ITI subnet2"
#  type = string
# }

# variable "subnet2-another-way" {
#  description = "this is the subnet2-tag-name variable with another way"
#  default = "new tag for ITI subnet2" 
#  type = string
# }

# variable "subnets-cidr" {
# description = "this is our subnet1 and subnet2 CIDRs"

# }
#------------------------------------------------------------------
#lab2

# Main VPC
resource "aws_vpc" "Ahmed-VPC" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "This is the main VPC"
  }
}

# Public Subnet with Default Route to Internet Gateway
resource "aws_subnet" "Ahmed-puplic-subnet1" {
  vpc_id            = aws_vpc.Ahmed-VPC.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "This is the puplic subnet1 in availability zone eu-west-1a"
  }
}

resource "aws_subnet" "Ahmed-puplic-subnet2" {
  vpc_id            = aws_vpc.Ahmed-VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "This is the puplic subnet2 in availability zone eu-west-1b"
  }
}

# Private Subnet with Default Route to NAT Gateway
resource "aws_subnet" "Ahmed-private-subnet1" {
  vpc_id            = aws_vpc.Ahmed-VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name = "This is the private subnet1 in availability zone eu-west-1a"
  }
}

resource "aws_subnet" "Ahmed-private-subnet2" {
  vpc_id            = aws_vpc.Ahmed-VPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name = "This is the private subnet2 in availability zone eu-west-1b"
  }
}



# Private PURE Subnets WITHOUT Route to NAT Gateway
resource "aws_subnet" "Ahmed-private-PURE1" {
  vpc_id     = aws_vpc.Ahmed-VPC.id
  availability_zone = "eu-west-1a"
  cidr_block        = "10.0.5.0/24"

  tags = {
    Name = "PURE subnet1 in availability zone eu-west-1a"
  }
}

resource "aws_subnet" "Ahmed-private-PURE2" {
  vpc_id     = aws_vpc.Ahmed-VPC.id
  availability_zone = "eu-west-1b"
  cidr_block        = "10.0.6.0/24"

  tags = {
    Name = "PURE subnet2 in availability zone eu-west-1b"
  }
}



# Main Internal Gateway for VPC
resource "aws_internet_gateway" "Ahmed-IGW" {
  vpc_id = aws_vpc.Ahmed-VPC.id

  tags = {
    Name = "This is the main internet gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "Ahmed-EIP" {
  vpc        = true
  depends_on = [aws_internet_gateway.Ahmed-IGW]
  tags = {
    Name = "This is the NAT gateway elastic IP"
  }
}

# Main NAT Gateway for VPC
resource "aws_nat_gateway" "Ahmed-NAT-GW" {
  allocation_id = aws_eip.Ahmed-EIP.id
  subnet_id     = aws_subnet.Ahmed-puplic-subnet1.id

  tags = {
    Name = "This is the main NAT gateway in puplic subnet1"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "Ahmed-puplic-table" {
  vpc_id = aws_vpc.Ahmed-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Ahmed-IGW.id
  }

  tags = {
    Name = "This is the puplic route table for our two subnets"
  }
}

# Association between Public Subnet1 and Public Route Table
resource "aws_route_table_association" "Ahmed-public-association1" {
  subnet_id      = aws_subnet.Ahmed-puplic-subnet1.id
  route_table_id = aws_route_table.Ahmed-puplic-table.id
}

# Association between Public Subnet2 and Public Route Table
resource "aws_route_table_association" "Ahmed-public-association2" {
  subnet_id      = aws_subnet.Ahmed-puplic-subnet2.id
  route_table_id = aws_route_table.Ahmed-puplic-table.id
}




# Route Table for Private Subnet1
resource "aws_route_table" "Ahmed-private-table1" {
  vpc_id = aws_vpc.Ahmed-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Ahmed-NAT-GW.id
  }

  tags = {
    Name = "This is the private route table1"
  }
}

# Route Table for Private Subnet2
resource "aws_route_table" "Ahmed-private-table2" {
  vpc_id = aws_vpc.Ahmed-VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Ahmed-NAT-GW.id
  }

  tags = {
    Name = "This is the private route table2"
  }
}

# Association between Private Subnet and Private Route Table
resource "aws_route_table_association" "Ahmed-private-association1" {
  subnet_id      = aws_subnet.Ahmed-private-subnet1.id
  route_table_id = aws_route_table.Ahmed-private-table1.id
}

# Association between Private Subnet and Private Route Table
resource "aws_route_table_association" "Ahmed-private-association2" {
  subnet_id      = aws_subnet.Ahmed-private-subnet2.id
  route_table_id = aws_route_table.Ahmed-private-table2.id
}






# Route Table for Private PURE Subnet1 and Subnet2
resource "aws_route_table" "Ahmed-private-PURE-table" {
  vpc_id = aws_vpc.Ahmed-VPC.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.Ahmed-NAT-GW.id
  # }

  tags = {
    Name = "This is the private PURE route table"
  }
}

# Association between Private PURE1 Subnet and Private Route Table
resource "aws_route_table_association" "Ahmed-private-PURE-association1" {
  subnet_id      = aws_subnet.Ahmed-private-PURE1.id
  route_table_id = aws_route_table.Ahmed-private-PURE-table.id
}

# Association between Private PURE2 Subnet and Private Route Table
resource "aws_route_table_association" "Ahmed-private-PURE-association2" {
  subnet_id      = aws_subnet.Ahmed-private-PURE2.id
  route_table_id = aws_route_table.Ahmed-private-PURE-table.id
}





# #creating our EC2

# resource "aws_instance" "AhmedEC2" {
#   ami               = "ami-08ca3fed11864d6bb"
#   instance_type     = "t2.micro"
#   availability_zone = "eu-west-1a"
#   key_name          = "My first EC2 instance"

#   user_data = <<-EOF
#               #!/bin/bash
#               sudo apt update -y
#               sudo apt install apache2 -y
#               sudo systemctl start apache2
#               sudo bash -c 'echo My first Terraform project by Ahmed Emad > /var/www/html/index.html'
#               EOF


#   tags = {
#     Name = "Task instance"
#   }
# }

# NOTE this EC2 instance failed to run with me for unknown reason 





