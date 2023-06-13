variable "team" {
  description = "Name of the Responsible Team"
  type        = string
  default     = "platform-team"
}

variable "environment" {
  description = "Name of the Environment"
  type        = string
  default     = "eks-prod"
}

########################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "kuhehub-cluster"
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

# Varible for EKS NodeGroup-Public
variable "node_group_name_public" {
  description = "Name of the EKS node group"
  type        = string
  default     = "eks-ng-public"
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





