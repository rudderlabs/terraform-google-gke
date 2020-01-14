output "cluster_endpoint" {
  description = "The IP address of the cluster master."
  value       = module.gke_cluster.endpoint
}

output "cluster_ca_certificate" {
  description = "The public certificate that is the root of trust for the cluster."
  value       = module.gke_cluster.cluster_ca_certificate
}
