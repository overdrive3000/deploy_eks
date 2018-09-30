# Deploying an AWS EKS Cluster with Terraform

This terraform templates makes use of the below modules to deploy an AWS EKS Cluster:

* [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules)
* [terraform_eks_cluster](https://github.com/overdrive3000/terraform_eks_cluster)
* [terraform_eks_nodes](https://github.com/overdrive3000/terraform_eks_nodes)
* [terraform_eks_join_nodes](https://github.com/overdrive3000/terraform_eks_join_nodes)

To use it just execute the following commands

```
$ terraform init
$ terraform plan -out firstdeploy
$ terraform apply firstdeploy
```

A whole description of how this template work can be found at (Deployin an AWS EKS Cluster)[https://www.linkedin.com/pulse/deploy-aws-eks-cluster-terraform-juan-mesa]
