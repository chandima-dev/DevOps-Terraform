# modules/gke/variables.tf

variable "region" {
  description = "The region in which GKE will be created"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "network" {
  description = "The VPC network to associate with the GKE cluster"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork to associate with the GKE cluster"
  type        = string
}

variable "node_machine_type" {
  description = "The machine type for general-purpose node pool"
  type        = string
}

variable "default_node_count" {
  description = "The number of nodes in the default node pool"
  type        = number
}

variable "cpu_intensive_node_count" {
  description = "The number of nodes in the CPU-intensive node pool"
  type        = number
}

variable "cpu_machine_type" {
  description = "The machine type for CPU-intensive node pool"
  type        = string
}
