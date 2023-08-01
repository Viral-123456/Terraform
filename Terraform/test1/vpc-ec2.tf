terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

##################  provider  ##################

provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA4EFZRT6X32AOI76P"
  secret_key = "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"
}

##################  VPC block  ##################

resource "aws_vpc" "vpc-1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc1"
  }
}

##################  Internet Gateway  ##################

resource "aws_internet_gateway" "vpc1-igw" {
  vpc_id = aws_vpc.vpc-1.id
  tags = {
    Name = "vpc1-igw"
  }
}

##################   Subnet  ##################

resource "aws_subnet" "pub-sub-1" {
  vpc_id     = aws_vpc.vpc-1.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "vpc1-pub-sun"
  }
}

##################### Route Table ###################

resource "aws_route_table" "vpc-1-pub-route" {
  vpc_id = aws_vpc.vpc-1.id
  route {}

  tags = {
    Name = "vpc1-pub-route"
  }
}

##################### Route  #####################

resource "aws_route" "pub-route-for-vpc1" {
  route_table_id            = aws_route_table.vpc-1-pub-route.id
  gateway_id             = aws_internet_gateway.vpc1-igw.id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on                = [aws_route_table.vpc-1-pub-route]
}

################# Route Table Association #################

resource "aws_route_table_association" "pub-rt-associaton" {
  subnet_id      = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.vpc-1-pub-route.id
}

################### Security Group ###################

resource "aws_security_group" "vpc1-sg" {
  name        = "vpc-1-sg"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "vpc-1-sg"
  }
}

################## EC2 ##################

resource "aws_instance" "ec2-v1" {
  count         = 2
  ami           = "ami-006935d9a6773e4ec" # ap-south-1
  instance_type = "t2.micro"

   tags = {
    Name = "vpc-1-ec2"
  }
}


################## EC2 Key pair ##################

resource "aws_key_pair" "vpc1-key" {
  key_name   = "vpc-1-key.pem"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}