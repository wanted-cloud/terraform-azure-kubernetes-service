/*
 * # wanted-cloud/terraform-azure-kubernetes-service
 * 
 * Terraform building block managing Azure Kubernetes Service and related resources.
 */

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = var.dns_prefix != "" ? var.dns_prefix : "${var.name}-dns"

  tags = merge(local.metadata.tags, var.tags)

  default_node_pool {
    name       = var.default_node_pool.name
    node_count = var.default_node_pool.node_count
    vm_size    = var.default_node_pool.vm_size

    os_sku = var.default_node_pool.os_sku
    zones  = var.default_node_pool.zones

    tags = merge(
      local.metadata.tags,
      var.default_node_pool.tags
    )

    vnet_subnet_id       = var.default_node_pool.subnet_id != null ? var.default_node_pool.subnet_id : null
    auto_scaling_enabled = var.default_node_pool.auto_scaling_enabled
    max_count            = var.default_node_pool.max_count != null ? var.default_node_pool.max_count : null
    min_count            = var.default_node_pool.min_count != null ? var.default_node_pool.min_count : null
  }

  identity {
    type         = var.identity_type
    identity_ids = var.user_assigned_identity_ids != [] ? var.user_assigned_identity_ids : null
  }
}