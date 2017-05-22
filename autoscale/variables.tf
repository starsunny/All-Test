/*
variables
*/
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_region" {}
variable "aws_key_name" {}
variable "vpc_cidr" {
    description = "cidr value for vpc"
    default = "10.0.0.0/16"
}

variable "pub_subnet_cidr" {
    description = "cidr value for public subnet in vpc"
    default = "10.0.0.0/24"
}

variable "pub2_subnet_cidr" {
    description = "cidr value for public subnet in vpc"
    default = "10.0.16.0/24"
}

variable "pvt_subnet_cidr" {
    description = "cidr value for private subnet in vpc"
    default = "10.0.32.0/24"
}

variable "backup_retention_period" {
    type = "string"
    description = "How long will we retain backups"
    default = 0
}





