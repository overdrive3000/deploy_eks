output "subnet_ids" {
  description = "List of IDs of public subnets"
  value       = "${module.vpc.public_subnets}"
}

output "vpc_id" {
  description = "EKS VPC Id"
  value       = "${module.vpc.vpc_id}"
}

output "endpoint" {
  description = "EKS Endpoint"
  value       = "${module.eks_cluster.endpoint}"
}

output "certificate-authority-data" {
  description = "EKS Certificate Authority Data"
  value       = "${module.eks_cluster.certificate-authority-data}"
}

output "kubeconfig" {
  description = "kubeconfig path"
  value       = "${module.join_cluster.kubeconfig}"
}
