output "vpc_id" {
  value = aws_vpc.tfe-vpc.id
}

output "vpc_cider_block" {
  value = aws_vpc.tfe-vpc.cidr_block
}

output "lb_public_subnet_1_id" {
  value = aws_subnet.lb-public-subnet1.id
}

output "lb_public_subnet_2_id" {
  value = aws_subnet.lb-public-subnet2.id
}

output "ec2_private_subnet_1_id" {
  value = aws_subnet.ec2-pri-subnet1.id
}

output "ec2_private_subnet_2_id" {
  value = aws_subnet.ec2-pri-subnet2.id
}

output "rds_private_subnet_1_id" {
  value = aws_subnet.rds-pri-subnet1.id
}

output "rds_private_subnet_2_id" {
  value = aws_subnet.rds-pri-subnet2.id
}

