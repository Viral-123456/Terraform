resource "aws_vpc" "vpc" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "vpc"
  }
}


resource "aws_subnet" "pub-sub1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub-sub1
  availability_zone       = var.availability_zone_pb1
  map_public_ip_on_launch = true

  tags = {
    Name = "pu-sub1"
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pub-sub2
  availability_zone       = var.availability_zone_pb2
  map_public_ip_on_launch = true

  tags = {
    Name = "pu-sub1"
  }
}

resource "aws_subnet" "pr-sub1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pr-sub1
  availability_zone = var.availability_zone_pr1

  tags = {
    Name = "pr-sub1"
  }
}

resource "aws_subnet" "pr-sub2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.pr-sub2
  availability_zone = var.availability_zone_pr2

  tags = {
    Name = "pr-sub1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_route_table" "pub-rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.pub-rt1-cidr
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "pub-rt1"
  }
}

resource "aws_route_table" "pub-rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.pub-rt2-cidr
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "pub-rt2"
  }
}


resource "aws_route_table" "pr1-rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.pr1-rt1-cidr
    gateway_id = aws_nat_gateway.nat_gateway.id
  }


  tags = {
    Name = "pr1-rt1"
  }
}

resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.elastic-ip.id
  subnet_id = aws_subnet.pr-sub1.id
  tags = {
    "Name" = "vpc nat-gateway"
  }
}


resource "aws_route_table_association" "pr1_rt1" {
  subnet_id      = aws_subnet.pr-sub1.id
  route_table_id = aws_route_table.pr1-rt1.id
}

resource "aws_route_table_association" "pb1_rt" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.pub-rt1.id
}

resource "aws_route_table_association" "pb2_rt" {
  subnet_id      = aws_subnet.pub-sub2.id
  route_table_id = aws_route_table.pub-rt2.id
}


resource "aws_security_group" "vpc-sg" {
  vpc_id = aws_vpc.vpc.id

  ingress {
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
    Name = "vpc-sg"
  }
}
