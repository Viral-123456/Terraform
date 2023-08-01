

# data "aws_vpc" "new_vpc" {
#   id = var.vpc_id
# }

data "aws_vpc" "new_vpc" {
   filter {
    name   = "tag:Name"
    values = ["vpc"]
  }

}

data "aws_subnet" "publicsubnet-vpc" {
  id = var.publicsubnet-vpc
}

data "aws_subnet" "privatesubnet-vpc" {
  id = var.privatesubnet-vpc

}

data "aws_security_group" "vpc_sg" {
  id = var.vpc_sg

}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}


resource "aws_instance" "ec2" {
  #count = var.instance_count
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # associate_public_ip_address = true
  subnet_id = data.aws_subnet.publicsubnet-vpc.id
  #subnet_id = data.aws_subnet.privatesubnet-vpc.id
  #count = var.ispublic == true ? 1 : 0  
  #count = var.ispublic ? 1 : 0
  count = var.ispublic ? var.instance_count : 0
  vpc_security_group_ids = [data.aws_security_group.vpc_sg.id]
  tags = {
    Name = "ec2"
  }
}

#new data########

resource "aws_instance" "ec21" {
  #count = var.instance_count
  ami   = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  # associate_public_ip_address = false
  #subnet_id = data.aws_subnet.publicsubnet-vpc.id
  subnet_id = data.aws_subnet.privatesubnet-vpc.id
  #count = var.isprivate == true ? 1 : 0
  #count = var.ispublic ? 0 : 1 
  count = var.ispublic ? 0 : var.instance_count  
  vpc_security_group_ids = [data.aws_security_group.vpc_sg.id]
  tags = {
    Name = "ec2"
  }
}






