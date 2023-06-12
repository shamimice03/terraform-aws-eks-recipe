## terraform-eks-prod-cluster
A production grade EKS cluster

## Configure aws credentials
```
aws configure --profile terraform-user
AWS Access Key ID [None]: 
AWS Secret Access Key [None]: 
Default region name [None]: 
Default output format [None]: 
```

## To-do
- [ ] Baston Host in Public Subnet so that we can ssh into eks_private_nodegroup instances.
- [ ] EKS Cluster
  - EKS Cluster IAM Role
  - EKS Cluster
- [ ] EKS Node Groups
  - EKS Node Group IAM Role
  - EKS Worker Nodes EC2 Instances