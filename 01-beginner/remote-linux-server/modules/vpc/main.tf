# VPC 
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "remote-linux-vpc"
  }
}

# PUBLIC SUBNETS
resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name = "remote-linux-public-subnet"
  }
}

# PRIVATE SUBNET
resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "remote-linux-private-subnet"
  }
}

# ROUTE TABLE - public
resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }

  tags = {
    Name = "remote-linux-rt-public"
  }
}

# ROUTE TABLE - private
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

  tags = {
    Name = "remote-linux-rt-private"
  }
}

# main RT <-> public subnet 1
resource "aws_route_table_association" "public_subnet_1_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.main_rt.id
}

# private RT <-> private subnet 1
resource "aws_route_table_association" "private_subnet_1_association" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_rt.id
}

# NAT Gateway has to be attached to the public subnet
# route table for the private subnet has to point to the NAT Gateway if going 0.0.0.0/0
# create an Elastic IP resource and attach it to NAT Gateway
