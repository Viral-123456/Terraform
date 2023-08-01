# outputs.tf

output "vpc_id" {
  value = aws_vpc.vpc1.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.pub1-sub-vpc1.id,
    aws_subnet.pub2-sub-vpc1.id
  ]
}


output "security_group_id" {
  value = aws_security_group.vpc1-sg.id
}
