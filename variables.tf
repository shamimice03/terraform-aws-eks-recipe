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




