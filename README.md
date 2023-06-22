# Provision `AWS EKS` cluster on a new VPC

```
create_new_vpc = true
vpc = {
  vpc_name                  = "kubecloud_eks_vpc"
  vpc_cidr                  = "10.0.0.0/16"
  azs                       = ["ap-northeast-1a", "ap-northeast-1c"]
  cluster_subnet_cidr       = ["10.0.0.0/20", "10.0.16.0/20"]
  public_subnet_cidr        = ["10.0.32.0/20","10.0.48.0/20"]
  private_subnet_cidr       = ["10.0.64.0/20", "10.0.80.0/20"]
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

```

# Provision `AWS EKS` cluster on an existing VPC
Suppose, there are 6 subnets with following subnet Id's:
 
```bash
intra_subnet_id = [
  "subnet-06e919d48f43eba1b",
  "subnet-0820c186039b2d4ac",
]
private_subnet_id = [
  "subnet-057c23897b5ea074f",
  "subnet-014e8b35dc15e7f29",
]
public_subnet_id = [
  "subnet-021604cca828cfb0d",
  "subnet-06c70c11d9fbd5fd5",
]
```
Now, we will deploy our EKS cluster in a way that EKS cluster's `X-ENI` will be created on `intra_subnets` . 

> intra_subnets: private subnet without any NAT gateway attached.

```tf

create_new_vpc                  = false
cluster_name                    = "eks-cluster"
existing_cluster_subnets        = ["subnet-06e919d48f43eba1b", "subnet-0820c186039b2d4ac"]
cluster_version                 = "1.27"
cluster_endpoint_private_access = false
cluster_endpoint_public_access  = true
cluster_public_access_cidrs     = ["0.0.0.0/0"]
cluster_service_ipv4_cidr       = "172.16.0.0/12"
cluster_log_types               = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

# managed nodegroup
node_groups = {

  one = {
    node_group_name = "kubecloud-eks-nodegroup-public"
    subnet_ids      = ["subnet-021604cca828cfb0d", "subnet-06c70c11d9fbd5fd5"]
    ami_type        = "AL2_x86_64"
    capacity_type   = "ON_DEMAND"
    disk_size       = 20
    instance_types  = ["t2.micro"]
    desired_size    = 2
    min_size        = 2
    max_size        = 4
    max_unavailable = 1
    tags = {
      Name = "kubecloud-eks-nodegroup"
    }
  },

  two = {
    node_group_name = "kubecloud-eks-nodegroup-private"
    subnet_ids      = ["subnet-057c23897b5ea074f", "subnet-014e8b35dc15e7f29", ]
    ami_type        = "AL2_x86_64"
    capacity_type   = "ON_DEMAND"
    disk_size       = 20
    instance_types  = ["t2.micro"]
    desired_size    = 1
    min_size        = 1
    max_size        = 4
    max_unavailable = 1
    tags = {
      Name = "kubecloud-eks-nodegroup"
    }
  }

}


```
