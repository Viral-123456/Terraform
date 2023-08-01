variable "vpc_cidr" {
  description = "cidr for vpc1"
  type        = string
  default     = ""
}

variable "region" {
  description = "Region"
  type = string
  default = "ap-south-1"
}

variable "pub1_subnet_cidr" {
  description = "cidr public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "pub2_subnet_cidr" {
  description = "cidr public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "pr1_subnet_cidr" {
  description = "cidr private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "pr2_subnet_cidr" {
  description = "cidr private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}
