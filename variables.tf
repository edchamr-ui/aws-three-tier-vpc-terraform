variable "vpc_name" {
  type        = string
  description = "The Name of the VPC Project"
  default     = "Edmond-Dev-VPC"
}



variable "vpc_cidr" {
  type        = string
  description = "The CIDR block of the VPC"
  default     = "10.0.0.0/16"
}



