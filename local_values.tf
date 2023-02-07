locals {
  name        = var.cluster_name
  team        = var.team
  environment = var.environment

  common_tags = {
    team        = local.team
    environment = local.environment
  }
}