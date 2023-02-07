locals {
  name = var.name
  team = var.team
  environment = var.environment

  common_tags = {
    team = local.team
    environment = local.environment
  }
}