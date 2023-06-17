terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.51"
    }
  }

  backend "s3" {
    bucket = "kubecloud-eks-clusters"
    key    = "kubecloud-nodegroups/nodegroup.tfstate"
    region = "ap-northeast-1"

    # For State Locking
    dynamodb_table = "kubecloud-eks-clusters"
  }
}