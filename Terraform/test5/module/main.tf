module "vpc" {
    source = "./vpc"
    region = var.region
    pub1_subnet_cidr = var.pub1_subnet_cidr
    pub2_subnet_cidr = var.pub2_subnet_cidr

}