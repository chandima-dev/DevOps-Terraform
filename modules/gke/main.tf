resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region
  initial_node_count = 1

  # Networking configuration
  network    = var.network
  subnetwork = var.subnetwork

  # Enable the API for Kubernetes Engine
  enable_kubernetes_alpha = true
  enable_legacy_abac      = false

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  # Add-ons configuration (fixed cloudrun_config)
  addons_config {
    cloudrun_config {
      disabled = false
    }
  }

  # Enable API
  master_auth {
    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "default_pool" {
  name               = "default-node-pool"
  location           = var.region
  cluster            = google_container_cluster.gke_cluster.name
  node_count         = var.default_node_count
  initial_node_count = var.default_node_count

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_container_node_pool" "cpu_intensive_pool" {
  name               = "cpu-intensive-node-pool"
  location           = var.region
  cluster            = google_container_cluster.gke_cluster.name
  node_count         = var.cpu_intensive_node_count
  initial_node_count = var.cpu_intensive_node_count

  node_config {
    machine_type = var.cpu_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

resource "google_storage_bucket" "terraform_state" {
  name          = var.bucket_name  # Referencing variable from tfvars
  location      = var.bucket_location  # Referencing variable from tfvars
  force_destroy = true
  uniform_bucket_level_access = true

  encryption {
    default_kms_key_name = var.kms_key_name  # Referencing variable from tfvars
  }
}



# Restrict the project to a specific value
resource "google_project" "restricted_project" {
  project_id = var.project_id

  # Restrict the project
  name       = "Restricted Project"
  org_id     = var.org_id  # Replace with your organization ID
  billing_account = var.billing_account_id  # Replace with your billing account ID

  lifecycle {
    prevent_destroy = true
  }
}
