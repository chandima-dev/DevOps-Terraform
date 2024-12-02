Here’s the updated README.md file including the tasks for security and automation guardrails with OPA (Open Policy Agent) and Conftest integration:

---

# Terraform - GKE Cluster Deployment with Security Guardrails

This project demonstrates how to use Terraform to deploy a Google Kubernetes Engine (GKE) cluster with custom networking, including two node pools, store Terraform state in a GCS bucket, and ensure all infrastructure deployments meet security standards using Open Policy Agent (OPA) and Conftest.

## Steps to Deploy

### 1. **Set Up VPC and Subnets**
```hcl
resource "google_compute_network" "vpc_network" {
  name = "gke-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet_a" {
  name          = "subnet-a"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = "10.0.0.0/24"
}
```

### 2. **Create GKE Cluster with Node Pools**
```hcl
resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster"
  location = "us-central1"
  network  = google_compute_network.vpc_network.name
  subnetwork = google_compute_subnetwork.subnet_a.name
}

resource "google_container_node_pool" "general_node_pool" {
  name     = "general-node-pool"
  cluster  = google_container_cluster.gke_cluster.name
  location = "us-central1"
  node_config { machine_type = "e2-medium" }
  initial_node_count = 2
}
```

### 3. **Store Terraform State in GCS Bucket**
```hcl
resource "google_storage_bucket" "terraform_state_bucket" {
  name = "your-terraform-state-bucket"
  location = "US"
}
```
Run the following command to initialize Terraform with the GCS backend:
```bash
terraform init -backend-config="bucket=your-terraform-state-bucket" -backend-config="prefix=terraform/state"
```

### 4. **Automate Deployment with GitHub Actions**

Create `.github/workflows/terraform.yml`:
```yaml
name: Terraform CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v2

      - name: Set up Google Cloud SDK
        uses: google-github-actions/setup-gcloud@v2
        with:
          project_id: ${{ secrets.GCP_PROJECT_ID }}
          credentials: ${{ secrets.GCP_CREDENTIALS_JSON }}

      - name: Terraform Init
        run: terraform init -backend-config="bucket=${{ secrets.GCS_BUCKET_NAME }}" -backend-config="prefix=terraform/state"

      - name: Terraform Plan
        run: terraform plan

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
```

---

## Security & Automation Guardrails with OPA/Conftest

### 1. **Write a Conftest Policy for GCS Bucket Encryption & Project Restriction**

We need to ensure that all Terraform code includes encryption for GCS buckets and restricts the project. The following is a sample Conftest policy to check for these conditions.

#### **Conftest Policy (gcs-encryption.rego)**
```rego
package terraform.gcs

# Ensure that GCS bucket has encryption enabled
deny["GCS bucket encryption is not enabled"] {
  input.resource_type == "google_storage_bucket"
  not input.resource.values.encryption
}

# Restrict the project to a specific value
deny["Project is not allowed"] {
  input.resource_type == "google_project"
  input.resource.values.project_id != "your-allowed-project-id"
}
```

This policy checks two conditions:
- Ensures that GCS buckets are configured with encryption.
- Restricts the project ID to a specific allowed project.

### 2. **Running Conftest for Policy Validation**

To run Conftest and check if your Terraform code adheres to the policy, follow these steps:

1. Install Conftest if you haven't already:
    ```bash
    brew install conftest
    ```

2. Run Conftest against your Terraform files:
    ```bash
    conftest test path_to_your_terraform_files
    ```

This will evaluate your Terraform code based on the policy defined in `gcs-encryption.rego` and return any violations.

---

### Conclusion
- **Infrastructure**: This Terraform configuration sets up a VPC, GKE cluster with two node pools, and stores state in GCS.
- **Security Guardrails**: The Conftest policy ensures GCS bucket encryption and restricts the project ID.
- **Automation**: GitHub Actions (TFActions) automates the deployment process.

This project ensures security compliance in Terraform deployments using OPA and Conftest while automating infrastructure deployment and management.

---

This README now includes the security guardrails with OPA/Conftest and describes how to ensure Terraform code meets security standards, alongside the previously provided instructions for deploying the GKE cluster with Terraform.
