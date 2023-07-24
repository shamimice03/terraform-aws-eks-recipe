output "nodegroup_arn" {
  description = "The ARN (Amazon Resource Name) of the EKS node group."
  value       = aws_eks_node_group.eks_nodegroup.arn
}

output "nodegroup_id" {
  description = "The ID of the EKS node group."
  value       = aws_eks_node_group.eks_nodegroup.id
}

output "nodegroup_role_arn" {
  description = "ARN of the EKS Nodegroup Role"
  value       = aws_iam_role.eks_nodegroup_role.name
}


