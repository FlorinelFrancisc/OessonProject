variable "aws_region" {
  description = "AWS region"
  default     = "eu-north-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_a_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_b_cidr" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t3.micro"
}
