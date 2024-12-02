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

# New variables for encryption and project restriction

variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
}

variable "org_id" {
  description = "The ID of the Google Cloud organization."
  type        = string
}

variable "billing_account_id" {
  description = "The billing account ID associated with the Google Cloud project."
  type        = string
}

variable "bucket_name" {
  description = "The name of the GCS bucket for Terraform state"
  type        = string
}

variable "bucket_location" {
  description = "The region where the GCS bucket will be created"
  type        = string
}

variable "kms_key_name" {
  description = "The KMS key to use for encrypting the bucket"
  type        = string
}
