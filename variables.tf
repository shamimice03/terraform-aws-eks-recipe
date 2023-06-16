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
  type = any
  default = {
    vpc_name                  = "kubecloud_eks_vpc"
    vpc_cidr                  = "10.0.0.0/16"
    azs                       = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
    public_subnet_cidr        = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
    private_subnet_cidr       = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
    enable_dns_hostnames      = true
    enable_dns_support        = true
    enable_single_nat_gateway = true
    tags = {
      Name = "EKS-VPC"
    }
  }
}

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
  type = list(any)
  default = [  ]
}
