module "vpc" {
    source = "./vpc"
    region = var.region
    cidr = var.cidr
    pub-sub1 = var.pub-sub1
    pub-sub2 = var.pub-sub2
    pr-sub1 = var.pr-sub1
    pr-sub2 = var.pr-sub2
    availability_zone_pb1 = var.availability_zone_pb1
    availability_zone_pb2 = var.availability_zone_pb2
    availability_zone_pr1 = var.availability_zone_pr1
    availability_zone_pr2 = var.availability_zone_pr2
    pub-rt1-cidr = var.pub-rt1-cidr
    pub-rt2-cidr = var.pub-rt2-cidr
    #pr1-rt1-cidr = var.pr1-rt1-cidr

}

