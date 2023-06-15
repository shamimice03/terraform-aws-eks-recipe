# Outputs
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "nodegroup_public_subnets" {
  value = module.prod_vpc.public_subnet_id
}

output "nodegroup_private_subnets" {
  value = module.prod_vpc.private_subnet_id
}