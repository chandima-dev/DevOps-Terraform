# variables.tf

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"  # You can change the region if required
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
  default     = "my-custom-vpc"  # You can change this name
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "my-subnet"  # You can change this name
}

variable "subnet_cidr" {
  description = "The CIDR range for the subnet"
  type        = string
  default     = "10.0.0.0/16"  # You can change the CIDR range if needed
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "my-gke-cluster"  # You can change the name of the GKE cluster
}

variable "node_machine_type" {
  description = "The machine type for general-purpose node pool"
  type        = string
  default     = "e2-medium"  # Change if needed
}

variable "default_node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
  default     = 3
}

variable "cpu_intensive_node_count" {
  description = "The number of nodes in the CPU-intensive node pool"
  type        = number
  default     = 3
}

variable "cpu_machine_type" {
  description = "The machine type for CPU-intensive node pool"
  type        = string
  default     = "c2-standard-4"  # Change if needed
}
