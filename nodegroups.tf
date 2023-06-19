module "eks_nodegroup" {
  source = "./modules/terraform-eks-nodegroup"

  for_each        = var.node_groups
  cluster_name    = var.cluster_name
  node_group_name = each.value.node_group_name
  subnet_ids      = each.value.subnet_ids
  ami_type        = each.value.ami_type
  capacity_type   = each.value.capacity_type
  disk_size       = each.value.disk_size
  instance_types  = each.value.instance_types
  desired_size    = each.value.desired_size
  min_size        = each.value.min_size
  max_size        = each.value.max_size
  max_unavailable = each.value.max_unavailable
  tags            = each.value.tags


}