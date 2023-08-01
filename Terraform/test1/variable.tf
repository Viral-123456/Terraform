variable "cidr" {
    type = string
    default = "10.0.0.0/16"
  
}


variable "ami" {
    type = string
    default = ""
  
}


variable "instance_type" {
    type = string
    default = "t2.micro"
}