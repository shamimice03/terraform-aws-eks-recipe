module "prod_vpc" {

  source = "github.com/shamimice03/terraform-aws-vpc"

  vpc_name = "prod_vpc"
  cidr     = "192.168.0.0/16"

  public_subnets = {
    "ap-northeast-1a" = "192.168.0.0/20",
    "ap-northeast-1c" = "192.168.16.0/20",
  }

  private_subnets = {
    "ap-northeast-1a" = "192.168.32.0/20"
    "ap-northeast-1c" = "192.168.48.0/20",
  }

  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = false

  tags = local.common_tags
}
