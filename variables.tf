variable "team" {
  description = "responsible team"
  type = string
  default = "platform-team"
}

variable "environment" {
   description = "responsible team"
   type = string
   default = "eks-prod"
}

############################

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type = string
  default = "kuhehub-cluster"
}