# ec2

data "aws_vpc" "vpc1" {
  id = "vpc-0199e66a95e803336"
}

data "aws_subnet" "pub1-sub-vpc1" {
  id = "subnet-0b8cb32416519b2fb"
}

resource "aws_instance" "ec2-vpc1" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  associate_public_ip_address = true  

   tags = {
    Name = "vpc-1-ec2"
  }
}


output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-vpc1.public_ip
}
