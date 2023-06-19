######################################################################
# Create New VPC
######################################################################

module "vpc" {
  count  = var.create_new_vpc ? 1 : 0
  source = "shamimice03/vpc/aws"

  vpc_name = var.vpc.vpc_name
  cidr     = var.vpc.vpc_cidr

  azs                 = var.vpc.azs
  intra_subnet_cidr   = var.vpc.cluster_subnet_cidr
  public_subnet_cidr  = var.vpc.public_subnet_cidr
  private_subnet_cidr = var.vpc.private_subnet_cidr

  enable_dns_hostnames      = var.vpc.enable_dns_hostnames
  enable_dns_support        = var.vpc.enable_dns_support
  enable_single_nat_gateway = var.vpc.enable_single_nat_gateway

  tags = local.common_tags
}
