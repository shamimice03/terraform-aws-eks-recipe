module "eks_nodegroup" {

  source = "./modules/terraform-eks-nodegroup"
  cluster_name    = var.cluster_name
  node_group_name = "kubecloud-eks-nodegroup"
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

}