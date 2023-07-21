# Outputs

output "cluster_name" {
  description = "The ID of the AWS EKS cluster."
  value       = aws_eks_cluster.eks_cluster.id
}

output "endpoint" {
  description = "The API server endpoint URL for accessing the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificzate-authority-data" {
  description = "The certificate authority data for the Kubernetes cluster."
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "vpc_config" {
  description = "The VPC configuration associated with the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.vpc_config
}

output "version" {
  description = "The version of the EKS cluster."
  value       = aws_eks_cluster.eks_cluster.version
}


# AWS IAM OIDC Provider ARN
output "aws_iam_openid_connect_provider_arn" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value       = module.eks_oidc[0].aws_iam_openid_connect_provider_arn
}

# Output: AWS IAM Open ID Connect Provider
output "oidc_provider" {
  description = "AWS IAM Open ID Connect Provider extract from ARN"
  value       = module.eks_oidc[0].oidc_provider
}



# output "vpc_public_subnets" {
#   description = "The public subnets associated with the EKS cluster's node group."
#   value       = module.vpc.public_subnet_id
# }

# output "vpc_private_subnets" {
#   description = "The private subnets associated with the EKS cluster's node group."
#   value       = module.vpc.private_subnet_id
# }
