module "ec2" {
    source = "./ec2-module"
    region = var.region
    instance_type = var.instance_type
    subnet_name = var.subnet_name
  
}