#data
data "aws_vpc" "vpc1" {
  id = var.vpc_id
}

data "aws_subnet" "pub1-sub-vpc1" {
  id = var.subnet_id
}

data "aws_security_group" "vpc1-sg" {
  id = var.security_group_id
}

resource "aws_instance" "ec2-vpc1" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  subnet_id                   = data.aws_subnet.pub1-sub-vpc1.id
  vpc_security_group_ids      = [data.aws_security_group.vpc1-sg.id]
  associate_public_ip_address = true  

  tags = {
    Name = "vpc-1-ec2"
  }
}
