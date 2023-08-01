resource "aws_instance" "ec2-1" {
    ami = "var.ami"
    instance_type = "var.instance"

    subnet_id                   = aws_subnet.pub_subnet.id
    vpc_security_group_ids      = [aws_security_group.vpc1-sg.id]
    associate_public_ip_address = true

    tags = {
    Name = "vpc-1-ec2"
  }
}




