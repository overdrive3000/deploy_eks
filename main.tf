module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.cluster_name}-vpc"
  cidr = "${var.vpc_cidr}"

  azs            = ["${var.azs}"]
  public_subnets = ["${var.vpc_subnet_cidr}"]

  public_subnet_tags = "${
    map(
     "kubernetes.io/cluster/${var.cluster_name}", "shared",
    )
  }"

  enable_dns_hostnames = true
  enable_nat_gateway   = true

  tags = "${
    map(
     "Name", "${var.cluster_name}-vpc",
     "Environment", "testing",
     "auto-delete", "false",
     "kubernetes.io/cluster/${var.cluster_name}", "shared",
    )
  }"
}

module "eks_cluster" {
  source = "github.com/overdrive3000/terraform_eks_cluster"

  cluster_name = "${var.cluster_name}"
  vpc_id       = "${module.vpc.vpc_id}"
  region       = "${var.region}"

  subnets = ["${module.vpc.public_subnets}"]
}

module "eks_workers" {
  source = "github.com/overdrive3000/terraform_eks_nodes"

  cluster_name     = "${var.cluster_name}"
  cluster_endpoint = "${module.eks_cluster.endpoint}"
  vpc_id           = "${module.vpc.vpc_id}"
  control_plane_sg = "${module.eks_cluster.security_group}"
  pub_key_pair     = "${var.pub_key_pair}"
  subnets          = ["${module.vpc.public_subnets}"]
  instance_profile = "${module.eks_cluster.node_instance_profile}"
  instance_type    = "m5.large"
  desired          = "3"
  min              = "1"
  max              = "4"
}

module "eks_tooling" {
  source = "github.com/overdrive3000/terraform_eks_nodes"

  cluster_name       = "${var.cluster_name}"
  cluster_endpoint   = "${module.eks_cluster.endpoint}"
  node_name          = "tooling"
  vpc_id             = "${module.vpc.vpc_id}"
  control_plane_sg   = "${module.eks_cluster.security_group}"
  pub_key_pair       = "${var.pub_key_pair}"
  subnets            = ["${module.vpc.public_subnets}"]
  instance_profile   = "${module.eks_cluster.node_instance_profile}"
  instance_type      = "t2.medium"
  desired            = "2"
  min                = "1"
  max                = "4"
  kubelet_extra_args = "--node-labels=tooling=yes --register-with-taints=tooling=true:NoSchedule"
}

module "join_cluster" {
  source = "github.com/overdrive3000/terraform_eks_join_nodes"

  cluster_name     = "${var.cluster_name}"
  region           = "${var.region}"
  cluster_endpoint = "${module.eks_cluster.endpoint}"
  cluster_ca       = "${module.eks_cluster.certificate-authority-data}"
  role             = "${module.eks_cluster.node_role_arn}"
}
