package terraform.gcs

# Ensure GCS bucket has encryption enabled
deny["GCS bucket encryption is not enabled"] {
  input.resource_type == "google_storage_bucket"
  not input.resource.values.encryption
}

# Restrict the project to a specific value
deny["Project is not allowed"] {
  input.resource_type == "google_project"
  input.resource.values.project_id != "var.project_id"  
}

# Restrict GCS bucket name to a specific value
deny["GCS bucket name is not allowed"] {
  input.resource_type == "google_storage_bucket"
  input.resource.values.name != "var.bucket_name"  
}
