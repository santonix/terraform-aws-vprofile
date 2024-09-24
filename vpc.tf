module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name            = var.vpc_name
  cidr            = var.vpc_cidr_block
  azs             = [var.zone1, var.zone2, var.zone3]
  private_subnets = [var.private_subnet1_cidr_block, var.private_subnet2_cidr_block, var.private_subnet3_cidr_block]
  public_subnets  = [var.public_subnet1_cidr_block, var.public_subnet2_cidr_block, var.public_subnet3_cidr_block]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dhcp_options  = true


  tags = {
    terraform   = "true"
    environment = "prod"
  }

  vpc_tags = {
    Name = var.vpc_name
  }
}

