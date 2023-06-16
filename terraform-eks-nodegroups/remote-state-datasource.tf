data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "kubecloud-eks-clusters"
    key    = "kubecloud-prod-cluster/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

