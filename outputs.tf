output "kubernetes_cluster_id" {
  description = "The ID of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.this.id
}

output "kubernetes_cluster_name" {
  description = "The name of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.this.name
}

output "fqdn" {
  description = "The FQDN of the Kubernetes cluster API server."
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "private_fqdn" {
  description = "The private FQDN of the Kubernetes cluster API server. Only set when private_cluster_enabled = true."
  value       = azurerm_kubernetes_cluster.this.private_fqdn
}

output "node_resource_group" {
  description = "The name of the Resource Group containing the Kubernetes cluster nodes."
  value       = azurerm_kubernetes_cluster.this.node_resource_group
}

output "node_resource_group_id" {
  description = "The ID of the Resource Group containing the Kubernetes cluster nodes."
  value       = azurerm_kubernetes_cluster.this.node_resource_group_id
}

output "oidc_issuer_url" {
  description = "The OIDC issuer URL of the Kubernetes cluster. Only set when oidc_issuer_enabled = true."
  value       = azurerm_kubernetes_cluster.this.oidc_issuer_url
}

output "identity" {
  description = "The identity block of the Kubernetes cluster."
  value       = azurerm_kubernetes_cluster.this.identity
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned managed identity of the Kubernetes cluster."
  value       = try(azurerm_kubernetes_cluster.this.identity[0].principal_id, null)
}

output "kubelet_identity" {
  description = "The kubelet identity block of the Kubernetes cluster. Used for ACR pull role assignments."
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}

output "current_kubernetes_version" {
  description = "The current version of Kubernetes running on the cluster."
  value       = azurerm_kubernetes_cluster.this.current_kubernetes_version
}

output "kube_config" {
  description = "The kubeconfig block of the Kubernetes cluster."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.this.kube_config
}

output "kube_config_raw" {
  description = "The raw kubeconfig of the Kubernetes cluster in YAML format."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
}

output "kube_admin_config" {
  description = "The admin kubeconfig block of the Kubernetes cluster. Only set when local_account_disabled = false."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.this.kube_admin_config
}

output "kube_admin_config_raw" {
  description = "The raw admin kubeconfig of the Kubernetes cluster in YAML format. Only set when local_account_disabled = false."
  sensitive   = true
  value       = azurerm_kubernetes_cluster.this.kube_admin_config_raw
}

output "portal_fqdn" {
  description = "The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster."
  value       = azurerm_kubernetes_cluster.this.portal_fqdn
}

output "http_application_routing_zone_name" {
  description = "The Zone Name of the HTTP Application Routing. Only set when http_application_routing_enabled = true."
  value       = azurerm_kubernetes_cluster.this.http_application_routing_zone_name
}

output "node_pool_ids" {
  description = "Map of additional node pool names to their resource IDs."
  value       = { for k, v in azurerm_kubernetes_cluster_node_pool.this : k => v.id }
}

output "key_vault_secrets_provider_identity_client_id" {
  description = "The client ID of the Key Vault Secrets Provider addon identity."
  value       = try(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].client_id, null)
}

output "key_vault_secrets_provider_identity_object_id" {
  description = "The object ID of the Key Vault Secrets Provider addon identity."
  value       = try(azurerm_kubernetes_cluster.this.key_vault_secrets_provider[0].secret_identity[0].object_id, null)
}
