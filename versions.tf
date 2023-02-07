terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.51"
    }
  }
}

provider "aws" {
  profile = "terraform-user"
}