resource "aws_vpc" "main" {
  cidr_block                   = var.vpc_cidr
  enable_dns_hostnames         = true
  enable_dns_support           = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "defaultIGW" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name     = "Workshop 1 Internet Gateway"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "my_elastic_ip" {
  domain   = "vpc"
}

# NAT Gateway
resource "aws_nat_gateway" "my_nat_gtw" {
  allocation_id = aws_eip.my_elastic_ip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = {
    Name = "NAT Gateway"
  }
}