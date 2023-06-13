# Configure Role for EKS Master
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


######################################################################

# Configure Role for EKS Worker Nodes
resource "aws_iam_role" "eks_nodegroup_role" {
  name = "${var.cluster_name}-eks-nodegroup-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_role_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_role_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodegroup_role.name
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_role_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodegroup_role.name
}

######################################################################
# EKS Cluster 
resource "aws_eks_cluster" "eks_cluster" {
  name     = "${var.cluster_name}-${local.environment}"
  role_arn = aws_iam_role.eks_master_role.arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = module.prod_vpc.public_subnet_id
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  enabled_cluster_log_types = var.cluster_log_types

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks_master_role_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks_master_role_AmazonEKSVPCResourceController,
  ]
}


######################################################################
# EKS Nodegroup - public

resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.cluster_name}-eks-ng-public"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.prod_vpc.public_subnet_id

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t2.micro"]


  # remote_access {
  #   ec2_ssh_key = "eks-terraform-key"
  # }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "public-node-group"
  }
}



######################################################################
# EKS Nodegroup - private

resource "aws_eks_node_group" "eks_ng_private" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.cluster_name}-eks-ng-public"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.prod_vpc.private_subnet_id

  ami_type       = "AL2_x86_64"
  capacity_type  = "ON_DEMAND"
  disk_size      = 20
  instance_types = ["t2.micro"]


  # remote_access {
  #   ec2_ssh_key = "eks-terraform-key"
  # }

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "private-node-group"
  }
}



# Outputs
output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
