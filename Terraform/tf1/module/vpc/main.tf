provider "aws" {
  region = "ap-south-1"
}

# vpc 
resource "aws_vpc" "vpc1" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

# igw
resource "aws_internet_gateway" "vpc1-igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-igw"
  }
}

# Public subnets
resource "aws_subnet" "pub1-sub-vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.pub1_subnet_cidr
  availability_zone = "ap-south-1a"

  tags = {
    Name = "pub1-sub-vpc1"
  }
}

resource "aws_subnet" "pub2-sub-vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.pub2_subnet_cidr
  availability_zone = "ap-south-1b"

  tags = {
    Name = "pub2-sub-vpc1"
  }
}

# Private subnets
resource "aws_subnet" "pr1-sub-vpc1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.pr1_subnet_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pr1-sub-vpc1"
  }
}

resource "aws_subnet" "pr2-sub-vpc1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.pr2_subnet_cidr
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "pr2-sub-vpc1"
  }
}

# Public route tables
resource "aws_route_table" "pub1-rt-vpc1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1-igw.id
  }

  tags = {
    Name = "pub1-route-vpc1"
  }
}

resource "aws_route_table" "pub2-rt-vpc1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1-igw.id
  }

  tags = {
    Name = "pub2-route-vpc1"
  }
}

# Route table associations for public subnets
resource "aws_route_table_association" "pub1-rt-association" {
  subnet_id      = aws_subnet.pub1-sub-vpc1.id
  route_table_id = aws_route_table.pub1-rt-vpc1.id
}

resource "aws_route_table_association" "pub2-rt-association" {
  subnet_id      = aws_subnet.pub2-sub-vpc1.id
  route_table_id = aws_route_table.pub2-rt-vpc1.id
}

# Security Group resource
resource "aws_security_group" "vpc1-sg" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.security_group_cidr_blocks
    ipv6_cidr_blocks = var.security_group_ipv6_cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = var.security_group_egress_cidr_blocks
    ipv6_cidr_blocks = var.security_group_ipv6_egress_cidr_blocks
  }
  tags = {
    Name = "vpc1-sg"
  }
}
