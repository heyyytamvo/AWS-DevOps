
module "vpc" {
  source                       = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
  
  name                         = var.vpc_name
  cidr                         = var.vpc_cidr
  
  azs                          = var.vpc_azs
  private_subnets              = var.vpc_private_subnets
  public_subnets               = var.vpc_public_subnets


  enable_dns_hostnames         = true
  enable_dns_support           = true
  enable_nat_gateway           = true
  single_nat_gateway           = true
  
}

# ## Create Internet Gateway for egress/ingress connections to resources in the public subnets

# resource "aws_internet_gateway" "defaultIGW" {
#   vpc_id = module.vpc..id

#   tags = {
#     Name     = "Default InternetGateway"
#   }
# }