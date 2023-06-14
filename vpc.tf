module "prod_vpc" {

  source = "shamimice03/vpc/aws"

  vpc_name = "eks_prod_vpc"
  cidr     = "192.168.0.0/16"

  azs                 = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  public_subnet_cidr  = ["192.168.0.0/20", "192.168.16.0/20", "192.168.32.0/20"]
  private_subnet_cidr = ["192.168.48.0/20", "192.168.64.0/20", "192.168.80.0/20"]

  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = true

  tags = local.common_tags
}
