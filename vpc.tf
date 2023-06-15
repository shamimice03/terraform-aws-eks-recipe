module "prod_vpc" {

  source = "shamimice03/vpc/aws"

  vpc_name = "eks_vpc"
  cidr     = "10.0.0.0/16"

  azs                 = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  public_subnet_cidr  = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  private_subnet_cidr = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]

  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = true

  tags = local.common_tags
}
