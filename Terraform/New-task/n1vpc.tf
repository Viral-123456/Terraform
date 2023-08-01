vpc.tf
[ec2-user@ip-172-31-5-131 module1]$ cat vpc.tf
# vpc
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
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

# pub-subnet
resource "aws_subnet" "pub1-sub-vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "pub1-sub-vpc1"
  }
}

resource "aws_subnet" "pub2-sub-vpc1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub2-sub-vpc1"
  }
}

resource "aws_subnet" "pr1-sub-vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "pr1-sub-vpc1"
  }
}
resource "aws_subnet" "pr2-sub-vpc1" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-south-1b"


  tags = {
    Name = "pr2-sub-vpc1"
  }
}




# route table
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


# route table
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


# route table association
resource "aws_route_table_association" "pub1-rt-association" {
  subnet_id      = aws_subnet.pub1-sub-vpc1.id
  route_table_id = aws_route_table.pub1-rt-vpc1.id
}


# route table association
resource "aws_route_table_association" "pub2-rt-association" {
  subnet_id      = aws_subnet.pub2-sub-vpc1.id
  route_table_id = aws_route_table.pub2-rt-vpc1.id
}


# security group
resource "aws_security_group" "vpc1-sg" {
  vpc_id      = aws_vpc.vpc1.id

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
    Name = "vpc1-sg"
  }
}











==========================

# ec2

resource "aws_instance" "ec2-vpc1" {
  ami           = "ami-006935d9a6773e4ec"
  instance_type = "t2.micro"

  subnet_id                   = "aws_subnet.pub1-sub-vpc1.id"
  vpc_security_group_ids      = ["aws_security_group.vpc1-sg.id"]
  associate_public_ip_address = true

  tags = {
    Name = "vpc-1-ec2"
  }
}

# output
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-vpc1.public_ip
}
