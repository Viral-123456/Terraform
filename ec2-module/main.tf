module "ec2" {
    source = "./ec2"
    region = var.region
    #ami = "data.aws_ami.ubuntu.id"
    instance_count = var.instance_count
    instance_type = var.instance_type
    #subnet_name = var.subnet_name
    ispublic = var.ispublic
    #isprivate = var.isprivate
   

}