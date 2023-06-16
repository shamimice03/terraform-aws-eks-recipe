create_new_vpc = true
vpc = {
  vpc_name                  = "kubecloud_eks_vpc"
  vpc_cidr                  = "10.0.0.0/16"
  azs                       = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  cluster_subnet_cidr       = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
  public_subnet_cidr        = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
  private_subnet_cidr       = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = true
  tags = {
    Name = "eks-vpc"
  }
}

cluster_name                    = "eks-cluster"
cluster_version                 = "1.27"
cluster_endpoint_private_access = false
cluster_endpoint_public_access  = true
cluster_public_access_cidrs     = ["0.0.0.0/0"]
cluster_service_ipv4_cidr       = "172.16.0.0/12"
cluster_log_types               = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

