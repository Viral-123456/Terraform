variable "region" {
    type = string
  
}


#variable "ami" {
    #type = string
  
#}

variable "instance_type" {
    type = string
  
}

variable "instance_count" {
    type = number
}



variable "ispublic" {
    type = bool
    default = false

}

#variable "isprivate" {

#}


# variable "vpc_id" {
#     default = "vpc-0c9a79eb274a1ccee"
  
# }

variable "vpc" {
    default = "vpc"

}

variable "publicsubnet-vpc" {
    default = "subnet-0303e0c28b92d5f50"
  
}


variable "privatesubnet-vpc" {
    default = "subnet-0d2598eaa95c48dfc"
  
}

variable "vpc_sg" {
    default = "sg-0f9466734ecf51164"
  
}