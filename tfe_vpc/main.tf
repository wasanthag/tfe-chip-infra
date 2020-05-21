provider "aws" {
  region = var.region
}

#terraform {
#  backend "s3" {
#  }
#}

resource "aws_vpc" "tfe-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_subnet" "lb-public-subnet1" {
  cidr_block        = var.lb_pub_subnet1_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1c"

  tags = {
    Name = "lb public subnet1"
  }
}

resource "aws_subnet" "lb-public-subnet2" {
  cidr_block        = var.lb_pub_subnet2_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1b"

  tags = {
    Name = "lb public subnet2"
  }
}

resource "aws_subnet" "ec2-pri-subnet1" {
  cidr_block        = var.ec2_pri_subnet1_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1c"

  tags = {
    Name = "ec2 private subnet1"
  }
}

resource "aws_subnet" "ec2-pri-subnet2" {
  cidr_block        = var.ec2_pri_subnet2_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1b"

  tags = {
    Name = "ec2 private subnet2"
  }
}

resource "aws_subnet" "rds-pri-subnet1" {
  cidr_block        = var.rds_pri_subnet1_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1c"

  tags = {
    Name = "rds private subnet1"
  }
}

resource "aws_subnet" "rds-pri-subnet2" {
  cidr_block        = var.rds_pri_subnet2_cidr
  vpc_id            = aws_vpc.tfe-vpc.id
  availability_zone = "us-west-1b"

  tags = {
    Name = "rds private subnet2"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.tfe-vpc.id
  tags = {
    Name = "lb public route table"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.tfe-vpc.id
  tags = {
    Name = "private route table"
  }
}

resource "aws_route_table_association" "public-subnet1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.lb-public-subnet1.id
}

resource "aws_route_table_association" "public-subnet2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.lb-public-subnet2.id
}

resource "aws_route_table_association" "ec2-pri-subnet1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.ec2-pri-subnet1.id
}

resource "aws_route_table_association" "ec2-pri-subnet2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.ec2-pri-subnet2.id
}

resource "aws_route_table_association" "rds-priv-subnet1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.rds-pri-subnet1.id
}

resource "aws_route_table_association" "rds-priv-subnet2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.rds-pri-subnet2.id
}

resource "aws_eip" "eip_nat_gw" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.eip_nat_gw.id
  subnet_id     = aws_subnet.lb-public-subnet1.id
  tags = {
    Name = "NAT GW"
  }
  #  depends_on = [aws_eip.eip_nat_gw]
}

resource "aws_route" "nat-gw-route" {
  route_table_id         = aws_route_table.private-route-table.id
  nat_gateway_id         = aws_nat_gateway.nat-gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tfe-vpc.id

  tags = {
    Name = "Internet GW"
  }
}

resource "aws_route" "public-igw-route" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

