output "vpc_id" {
  value       = aws_vpc.vpc.id
}

output "subnet_pub1_id" {
    value = aws_subnet.pub-sub1.id
}

output "subnet_pub2_id" {
    value = aws_subnet.pub-sub2.id
}

output "subnet_pr1_id" {
    value = aws_subnet.pr-sub1.id
}

output "subnet-pr2_id" {
    value = aws_subnet.pr-sub2.id
}