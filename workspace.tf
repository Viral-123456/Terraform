provider "aws" {
 region = "ap-south-1"
}

variable "instance_type"
 type = map(any)
 default = {
   default = "t2.nano"
   dev     = "t2.micro"
   test    = "t2.small"
}

resource "aws_instance" "ec2" {
  ami           = "ami-vksmxvkmlsvs"
  instance_type = lookup(var.instance_type, terraform.workspace)
}

======

terraform workspace list
terraform workspace new dev
terraform workspace new test
terraform workspace list
terraform workspace select dev
