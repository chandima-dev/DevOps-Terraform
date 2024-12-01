terraform {
  backend "gcs" {
    bucket  = "devops-terraform-99"
    prefix  = "terraform/state"
  }
}
