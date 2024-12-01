# main.tf

# Google Provider Configuration
provider "google" {
  project = var.project_id
  region  = var.region
}

# Call the vpc module
module "vpc" {
  source     = "./modules/vpc"
  region     = var.region
  vpc_name   = var.vpc_name
  subnet_name = var.subnet_name
  subnet_cidr = var.subnet_cidr
}


# Call the gke module to create the GKE cluster and node pools
module "gke" {
  source           = "./modules/gke"
  region           = var.region
  cluster_name     = var.cluster_name
  network          = module.vpc.vpc_name
  subnetwork       = module.vpc.subnet_name
  node_machine_type = var.node_machine_type
  default_node_count = var.default_node_count
  cpu_intensive_node_count = var.cpu_intensive_node_count
  cpu_machine_type = var.cpu_machine_type
}

# Outputs
output "gke_cluster_name" {
  value = module.gke.gke_cluster_name
}

output "default_node_pool_name" {
  value = module.gke.default_node_pool_name
}

output "cpu_intensive_node_pool_name" {
  value = module.gke.cpu_intensive_node_pool_name
}

output "vpc_name" {
  value = module.vpc.vpc_name
}

output "subnet_name" {
  value = module.vpc.subnet_name
}
