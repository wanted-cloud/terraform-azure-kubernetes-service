resource "azurerm_kubernetes_cluster_node_pool" "this" {
  for_each = {
    for pool in var.additional_node_pools : pool.name => pool
  }

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count

  os_type  = each.value.os_type
  os_sku   = each.value.os_sku
  priority = each.value.priority
  zones    = each.value.zones

  vnet_subnet_id       = each.value.subnet_id != null ? each.value.subnet_id : null
  auto_scaling_enabled = each.value.auto_scaling_enabled
  max_count            = each.value.max_count != null ? each.value.max_count : null
  min_count            = each.value.min_count != null ? each.value.min_count : null

  tags = merge(
    local.metadata.tags,
    each.value.tags
  )

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster_node_pool"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster_node_pool"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster_node_pool"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster_node_pool"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}