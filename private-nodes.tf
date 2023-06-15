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


#######################################################################
# EKS Nodegroup - public

resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.cluster_name}-${var.node_group_name_public}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.prod_vpc.public_subnet_id

  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types


  # remote_access {
  #   ec2_ssh_key = "eks-terraform-key"
  # }

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = var.max_unavailable
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



#### Private
resource "aws_eks_node_group" "eks_ng_private" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  node_group_name = "${var.cluster_name}-${var.node_group_name_private}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = module.prod_vpc.private_subnet_id

  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types


  # remote_access {
  #   ec2_ssh_key = "eks-terraform-key"
  # }

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = var.max_unavailable
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

########################################################################
# EKS Nodegroup - private

# resource "aws_eks_node_group" "eks_ng_private" {
#   cluster_name = aws_eks_cluster.eks_cluster.name

#   node_group_name = "${var.cluster_name}-eks-ng-public"
#   node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
#   subnet_ids      = module.prod_vpc.private_subnet_id

#   ami_type       = "AL2_x86_64"
#   capacity_type  = "ON_DEMAND"
#   disk_size      = 20
#   instance_types = ["t2.micro"]


#   # remote_access {
#   #   ec2_ssh_key = "eks-terraform-key"
#   # }

#   scaling_config {
#     desired_size = 1
#     min_size     = 1
#     max_size     = 2
#   }

#   # Desired max percentage of unavailable worker nodes during node group update.
#   update_config {
#     max_unavailable = 1
#   }

#   # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
#   # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
#   depends_on = [
#     aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.eks_nodegroup_role_AmazonEC2ContainerRegistryReadOnly,
#   ]

#   tags = {
#     Name = "private-node-group"
#   }
# }


