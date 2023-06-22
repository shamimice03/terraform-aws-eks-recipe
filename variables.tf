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
#               Cluster Variables
########################################################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "cluster_subnets" {
  type    = list(any)
  default = []
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

variable "tags" {
  type = map(any)
  default ={}
}

########################################################
#               Nodegroup Variables
########################################################

variable "node_groups" {
  type = map(object({
    node_group_name = string
    subnet_ids      = list(string)
    ami_type        = string
    capacity_type   = string
    disk_size       = number
    instance_types  = list(string)
    desired_size    = number
    min_size        = number
    max_size        = number
    max_unavailable = number
    tags            = map(string)
  }))
}

########################################################
#       IAM Role for Service Account - IRSA
########################################################

variable "enable_irsa" {
  description = "This will add EKS OIDC endpoint Url in IAM Identity providers section"
  type        = bool
  default     = true
}