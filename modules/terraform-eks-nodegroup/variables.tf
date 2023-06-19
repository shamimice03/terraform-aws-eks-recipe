###############################################################
variable "node_group_name" {
  description = "Name of the EKS node group"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
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



