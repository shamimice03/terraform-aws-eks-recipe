locals {
  name        = var.cluster_name
  team        = var.team
  environment = var.environment

  common_tags = {
    team        = local.team
    environment = local.environment
  }
}

######################################################################
# Configure Role for EKS Controlplane
######################################################################

resource "aws_iam_role" "eks_master_role" {
  name = "${var.cluster_name}-eks-master-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_master_role_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_master_role.name
}

resource "aws_iam_role_policy_attachment" "eks_master_role_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_master_role.name
}


# ######################################################################
# # EKS cluster configurations
# ######################################################################
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.cluster_subnets
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = var.cluster_log_types


  tags = merge(local.common_tags, { "Name" = var.cluster_name })

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_master_role_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_master_role_AmazonEKSVPCResourceController
  ]
}

# ######################################################################
# # EKS nodegroup configurations
# ######################################################################

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

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}

# ######################################################################
# # EKS OIDC configurations
# ######################################################################

module "eks_oidc" {
  source = "./modules/eks-oidc"

  count        = var.attach_eks_oidc_with_iam ? 1 : 0
  cluster_name = var.cluster_name

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}
