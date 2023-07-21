cluster_name                    = "kubecloud-eks-1"
cluster_subnets                 = ["subnet-06e919d48f43eba1b", "subnet-0820c186039b2d4ac"]
cluster_version                 = "1.27"
cluster_endpoint_private_access = false
cluster_endpoint_public_access  = true
cluster_public_access_cidrs     = ["0.0.0.0/0"]
cluster_service_ipv4_cidr       = "172.16.0.0/12"
cluster_log_types               = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
attach_eks_oidc_with_iam        = true

# managed nodegroup
node_groups = {

  one = {
    node_group_name = "kubecloud-eks-nodegroup-public"
    subnet_ids      = ["subnet-021604cca828cfb0d", "subnet-06c70c11d9fbd5fd5"]
    ami_type        = "AL2_x86_64"
    capacity_type   = "ON_DEMAND"
    disk_size       = 8
    instance_types  = ["t3.small"]
    desired_size    = 4
    min_size        = 4
    max_size        = 10
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
    disk_size       = 8
    instance_types  = ["t2.micro"]
    desired_size    = 0
    min_size        = 0
    max_size        = 8
    max_unavailable = 1
    tags = {
      Name = "kubecloud-eks-nodegroup"
    }
  }

}

