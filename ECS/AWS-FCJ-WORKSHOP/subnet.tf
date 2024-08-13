resource "aws_subnet" "public_subnet_1" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vpc_public_subnets[0]
  availability_zone   = var.vpc_azs[0]

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vpc_public_subnets[1]
  availability_zone   = var.vpc_azs[1]

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vpc_private_subnets[0]
  availability_zone   = var.vpc_azs[0]

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id              = aws_vpc.main.id
  cidr_block          = var.vpc_private_subnets[1]
  availability_zone   = var.vpc_azs[1]

  tags = {
    Name = "Private Subnet 2"
  }
}