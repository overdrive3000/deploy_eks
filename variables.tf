#
# Variables Configuration
#

variable "cluster_name" {
  default = "EksTestBed"
  type    = "string"
}

variable "region" {
  default = "eu-west-1"
  type    = "string"
}

variable "azs" {
  default = [
    "eu-west-1a",
    "eu-west-1b",
    "eu-west-1c",
  ]

  type = "list"
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
  type    = "string"
}

variable "vpc_subnet_cidr" {
  default = [
    "192.168.64.0/18",
    "192.168.128.0/18",
    "192.168.192.0/18",
  ]

  type = "list"
}

variable "worker_instance_type" {
  default = "m4.large"
  type    = "string"
}

variable "tooling_instance_type" {
  default = "t3.medium"
  type    = "string"
}

variable "pub_key_pair" {
  default = ""
  type    = "string"
}

variable "node_name" {
  default = "worker"
  type    = "string"
}
