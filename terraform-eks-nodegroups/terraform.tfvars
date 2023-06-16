cluster_name = "kubecloud-eks-cluster"
node_group_name = "kubecloud-eks-nodegroup"
subnet_ids = []
ami_type = "AL2_x86_64"
capacity_type  = "ON_DEMAND"
disk_size      = 20
instance_types =  ["t2.micro"]

# remote_access {
#   ec2_ssh_key = "eks-terraform-key"
# }

scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 1
  }

# Desired max percentage of unavailable worker nodes during node group update.
update_config {
    max_unavailable = 1
  }


