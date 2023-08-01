# ec2
resource "aws_instance" "ec2-vpc1" {
  ami           = "ami-08e5424edfe926b43"
  instance_type = "t2.micro"
  subnet_id                   = "aws_subnet.pub1-sub-vpc1.id"
  vpc_security_group_ids      = ["aws_security_group.vpc1-sg.id"]
  associate_public_ip_address = true  

   tags = {
    Name = "vpc-1-ec2"
  }
}


output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.ec2-vpc1.public_ip
}
