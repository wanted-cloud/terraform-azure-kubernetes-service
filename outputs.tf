output "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.id
}

output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.kubernetes_cluster.name
}

