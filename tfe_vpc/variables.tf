variable "region" {
  default     = "us-west-1"
  description = "tfe region"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = " tfe vpc cidr"
}

variable "lb_pub_subnet1_cidr" {
  description = "public subnet 1"
}

variable "lb_pub_subnet2_cidr" {
  description = "public subnet 2"
}

variable "ec2_pri_subnet1_cidr" {
  description = "ec2 private subnet 1"
}

variable "ec2_pri_subnet2_cidr" {
  description = "ec2 private subnet 2"
}

variable "rds_pri_subnet1_cidr" {
  description = "db private subnet 1"
}

variable "rds_pri_subnet2_cidr" {
  description = "db private subnet 2"
}

