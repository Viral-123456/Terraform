
data "aws_vpc" "new_vpc" {
  filter {
    name   = "Name"
    values = ["vpc"]
  }
}

data "aws_subnet" "publicsubnet-vpc" {
    filter {
    name   = "Name"
    values = [pub-sub1]
  }
}

data "aws_security_group" "vpc_sg" {
      filter {
    name   = "Name"
    values = ["vpc-sg"]
  }
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

}


resource "aws_instance" "ec2" {
  ami = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = data.aws_subnet.publicsubnet-vpc.id
  vpc_security_group_ids = [data.aws_security_group.vpc_sg.id]
  tags = {
    Name = "ec2"
  }
}
