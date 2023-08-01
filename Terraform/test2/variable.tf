# variables.tf

variable "vpc_cidr" {
  description = "cidr for vpc1"
  type        = string
  default     = "10.0.0.0/16"
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


variable "security_group_id" {

  type        = string
  default     = null
}


variable "security_group_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_ipv6_cidr_blocks" {
  type        = list(string)
  default     = ["::/0"]
}

variable "security_group_egress_cidr_blocks" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "security_group_ipv6_egress_cidr_blocks" {
  type        = list(string)
  default     = ["::/0"]
}