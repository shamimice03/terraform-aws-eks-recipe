# AWS IAM OIDC Provider ARN
output "aws_iam_openid_connect_provider_arn" {
  description = "AWS IAM Open ID Connect Provider ARN"
  value       = aws_iam_openid_connect_provider.this.arn
}

# Extract OIDC Provider from OIDC Provider ARN
# ARN : arn:aws:iam::391178969547:oidc-provider/oidc.eks.ap-northeast-1.amazonaws.com/id/39FD3600FE0539
locals {
  oidc_provider = element(split("oidc-provider/", "${aws_iam_openid_connect_provider.this.arn}"), 1)
}

# Output: AWS IAM Open ID Connect Provider
output "oidc_provider" {
  description = "AWS IAM Open ID Connect Provider extract from ARN"
  value       = local.oidc_provider
}


