
####################### provider #######################
provider "aws" {
  region = "ap-south-1"
}

####################### vpc #######################
resource "aws_vpc" "vpc-1" {
  cidr_block = "10.0.0.0/16"
}

####################### public subnet #######################
resource "aws_default_subnet" "pub-subnet" {
  availability_zone = "ap-south-1"

  tags = {
    Name = "pub-sub-vpc1"
  }
}

####################### internet gateway #######################
resource "aws_internet_gateway" "igw-vpc1" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "vpc1-igw"
  }
}

####################### public route table #######################
resource "aws_route_table" "pub-route" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "pub-route"
  }
}

####################### route define #######################
resource "aws_route" "new-route" {
  route_table_id            = aws_route_table.pub-route.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw-vpc1.id
  depends_on                = [aws_route_table.pub-route]
}

####################### aws_route_table_association #######################
resource "aws_route_table_association" "rt-assoiciation" {
  subnet_id      = aws_default_subnet.pub-subnet.id
  route_table_id = aws_route_table.pub-route.id
}

resource "aws_security_group" "vpc1-sg" {
  name        = "vpc1-sg"
  description = "Allow all traffic"
  vpc_id      = aws_vpc.vpc-1.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "vpc1-sg"
  }
}


####################### ec2 #######################

resource "aws_instance" "new-ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
   
  security_groups = aws_security_group.vpc1-sg.id
  subnet_id                   = aws_default_subnet.pub-subnet.id
  associate_public_ip_address = true
  


  tags = {
    Name = "vpc1-server"
  }
}