variable "cidr" {
    type = string
    default = "10.0.0.0/16"
  
}


variable "pub_subnet" {
    vipc_id = aws_vpc.vpc-1.id
    cidr_block = "10.0.1.0/24"

    tag = {
        Name = pub-sub-vpc1
    }
}


variable "igw-1" {
    vpc_id = aws_vpc.vpc-1.id

    tag = {
        Name = vpc1-igw
    }
}