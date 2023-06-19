variable "team" {
  description = "Name of the Responsible Team"
  type        = string
  default     = "platform-team"
}

variable "environment" {
  description = "Name of the Environment"
  type        = string
  default     = "dev"
}
########################################################
variable "create_new_vpc" {
  type    = bool
  default = true
}

variable "vpc" {
  description = "VPC configurations for creating new VPC"
  type        = any
  default     = {}
}
# variable "vpc" {
#   type = any
#   default = {
#     vpc_name                  = "kubecloud_eks_vpc"
#     vpc_cidr                  = "10.0.0.0/16"
#     azs                       = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
#     cluster_subnet_cidr       = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
#     public_subnet_cidr        = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
#     private_subnet_cidr       = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
#     enable_dns_hostnames      = true
#     enable_dns_support        = true
#     enable_single_nat_gateway = true
#     tags = {
#       Name = "EKS-VPC"
#     }
#   }
# }

# variable "vpc_name" {
#   type = string
#   default = "kubecloud_eks_vpc"
# }

# variable "vpc_cidr" {
#   type = string
#   default = "10.0.0.0/16"
# }

# variable "azs" {
#   type = list
#   default = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
# }

# variable "public_subnet_cidr" {
#   type = list(any)
#   default =  ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
# }

# variable "private_subnet_cidr" {
#   type = list
#   default = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
# }

# variable "enable_dns_hostnames" {
#   type = bool
#   default = true
# }

# variable "enable_dns_support" {
#   type = bool
#   default = true
# }

# variable "enable_single_nat_gateway" {
#   type = bool
#   default = false
# }

# variable "tags" {
#   type = map(any)
#   default = {
#     Name = "EKS-VPC"
#   }
# }

########################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "cluster_version" {
  description = "Define EKS-Kubernetes Version"
  type        = string
  default     = "1.27"
}
variable "cluster_endpoint_private_access" {
  default = false
}

variable "cluster_endpoint_public_access" {
  default = true
}

variable "cluster_public_access_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "cluster_service_ipv4_cidr" {
  default = "172.16.0.0/12"
}

variable "cluster_log_types" {
  default = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]
}

variable "existing_cluster_subnets" {
  type    = list(any)
  default = []
}


################# nodegroup ####################


variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Name of the EKS cluster"
  type        = list(any)
  default     = []
}

variable "ami_type" {
  description = "AMI type for the EKS node group instances"
  type        = string
  default     = "AL2_x86_64"
}

variable "capacity_type" {
  description = "Capacity type for the EKS node group instances"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Disk size in GB for the EKS node group instances"
  type        = number
  default     = 20
}

variable "instance_types" {
  description = "List of instance types for the EKS node group instances"
  type        = list(string)
  default     = ["t2.micro"]
}

variable "desired_size" {
  description = "Desired number of instances in the EKS node group"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of instances in the EKS node group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the EKS node group"
  type        = number
  default     = 2
}

variable "max_unavailable" {
  description = "Desired max percentage of unavailable worker nodes during node group update"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Node Group Tags"
  type        = map(any)
  default = {
    Name = "EKS-Node-Group"
  }
}