resource "aws_vpc "vpc-1" {
    cidr_block = "var.cidr"
    instance_tenancy = "default"

    tag = {
        Name = vpc1
    }
}


resource "aws_internet_gateway" "var.igw" {
    
}


resource "aws_subnet" "var.pub_subnet" {
   
}


resource "aws_route_table" "pub-route-vpc1" {
    vpc_id = aws_vpc.vpc-1.idcheck 

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-1.id
  }

    tag = {
        Name = "pub-route-vpc1"
    }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.pub_subnet.id
  route_table_id = aws_route_table.pub-route-vpc1.id
}

resource "aws_security_group" "vpc1-sg" {
  name        = "sg-vpc1"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [0.0.0.0/0]
    ipv6_cidr_blocks = []
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