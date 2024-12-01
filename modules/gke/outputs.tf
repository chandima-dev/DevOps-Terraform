# modules/gke/outputs.tf

output "gke_cluster_name" {
  value = google_container_cluster.gke_cluster.name
}

output "default_node_pool_name" {
  value = google_container_node_pool.default_pool.name
}

output "cpu_intensive_node_pool_name" {
  value = google_container_node_pool.cpu_intensive_pool.name
}
