terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.51"
    }
  }

  backend "s3" {
    bucket = "kubecloud-eks-clusters"
    key    = "kubecloud-prod-cluster/terraform.tfstate"
    region = "ap-northeast-1"

    # For State Locking
    dynamodb_table = "kubecloud-prod-cluster"
  }
}

# provider "aws" {
#   profile = "terraform-user"
# }

