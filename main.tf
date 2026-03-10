/*
 * # wanted-cloud/terraform-azure-kubernetes-service
 *
 * Terraform building block managing Azure Kubernetes Service and related resources.
 */

resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = coalesce(var.location, data.azurerm_resource_group.this.location)
  resource_group_name = data.azurerm_resource_group.this.name
  dns_prefix          = coalesce(var.dns_prefix, "${var.name}-dns")

  kubernetes_version        = var.kubernetes_version
  automatic_upgrade_channel = var.automatic_upgrade_channel
  node_os_upgrade_channel   = var.node_os_upgrade_channel

  sku_tier = var.sku_tier

  private_cluster_enabled             = var.private_cluster_enabled
  private_dns_zone_id                 = var.private_cluster_enabled ? var.private_dns_zone_id : null
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled

  role_based_access_control_enabled = var.role_based_access_control_enabled
  local_account_disabled            = var.local_account_disabled

  workload_identity_enabled = var.workload_identity_enabled
  oidc_issuer_enabled       = var.oidc_issuer_enabled

  tags = merge(local.metadata.tags, var.tags)

  default_node_pool {
    name    = var.default_node_pool.name
    vm_size = var.default_node_pool.vm_size

    node_count           = var.default_node_pool.node_count
    auto_scaling_enabled = var.default_node_pool.auto_scaling_enabled
    max_count            = var.default_node_pool.max_count
    min_count            = var.default_node_pool.min_count

    os_sku = var.default_node_pool.os_sku
    zones  = var.default_node_pool.zones
    type   = var.default_node_pool.type

    os_disk_size_gb = var.default_node_pool.os_disk_size_gb
    os_disk_type    = var.default_node_pool.os_disk_type
    max_pods        = var.default_node_pool.max_pods

    vnet_subnet_id = var.default_node_pool.subnet_id
    pod_subnet_id  = var.default_node_pool.pod_subnet_id

    node_labels                  = var.default_node_pool.node_labels
    only_critical_addons_enabled = var.default_node_pool.only_critical_addons_enabled
    orchestrator_version         = var.default_node_pool.orchestrator_version

    scale_down_mode        = var.default_node_pool.scale_down_mode
    node_public_ip_enabled = var.default_node_pool.node_public_ip_enabled

    temporary_name_for_rotation = var.default_node_pool.temporary_name_for_rotation

    tags = merge(local.metadata.tags, var.default_node_pool.tags)

    dynamic "upgrade_settings" {
      for_each = var.default_node_pool.upgrade_settings != null ? [var.default_node_pool.upgrade_settings] : []
      content {
        drain_timeout_in_minutes      = upgrade_settings.value.drain_timeout_in_minutes
        node_soak_duration_in_minutes = upgrade_settings.value.node_soak_duration_in_minutes
        max_surge                     = upgrade_settings.value.max_surge
      }
    }

    dynamic "kubelet_config" {
      for_each = var.default_node_pool.kubelet_config != null ? [var.default_node_pool.kubelet_config] : []
      content {
        cpu_manager_policy        = kubelet_config.value.cpu_manager_policy
        cpu_cfs_quota_enabled     = kubelet_config.value.cpu_cfs_quota_enabled
        cpu_cfs_quota_period      = kubelet_config.value.cpu_cfs_quota_period
        image_gc_high_threshold   = kubelet_config.value.image_gc_high_threshold
        image_gc_low_threshold    = kubelet_config.value.image_gc_low_threshold
        topology_manager_policy   = kubelet_config.value.topology_manager_policy
        allowed_unsafe_sysctls    = kubelet_config.value.allowed_unsafe_sysctls
        container_log_max_size_mb = kubelet_config.value.container_log_max_size_mb
        container_log_max_line    = kubelet_config.value.container_log_max_line
        pod_max_pid               = kubelet_config.value.pod_max_pid
      }
    }

    dynamic "linux_os_config" {
      for_each = var.default_node_pool.linux_os_config != null ? [var.default_node_pool.linux_os_config] : []
      content {
        swap_file_size_mb             = linux_os_config.value.swap_file_size_mb
        transparent_huge_page_enabled = linux_os_config.value.transparent_huge_page_enabled
        transparent_huge_page_defrag  = linux_os_config.value.transparent_huge_page_defrag

        dynamic "sysctl_config" {
          for_each = linux_os_config.value.sysctl_config != null ? [linux_os_config.value.sysctl_config] : []
          content {
            fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
            fs_file_max                        = sysctl_config.value.fs_file_max
            fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
            fs_nr_open                         = sysctl_config.value.fs_nr_open
            kernel_threads_max                 = sysctl_config.value.kernel_threads_max
            net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
            net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
            net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
            net_core_rmem_max                  = sysctl_config.value.net_core_rmem_max
            net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
            net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
            net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
            net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
            net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
            net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
            net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
            net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
            net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
            net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
            net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
            net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
            net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
            net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
            net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
            net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
            net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
            vm_max_map_count                   = sysctl_config.value.vm_max_map_count
            vm_swappiness                      = sysctl_config.value.vm_swappiness
            vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
          }
        }
      }
    }
  }

  identity {
    type         = var.identity_type
    identity_ids = length(var.user_assigned_identity_ids) > 0 ? var.user_assigned_identity_ids : null
  }

  dynamic "network_profile" {
    for_each = var.network_profile != null ? [var.network_profile] : []
    content {
      network_plugin      = network_profile.value.network_plugin
      network_policy      = network_profile.value.network_policy
      network_plugin_mode = network_profile.value.network_plugin_mode
      network_data_plane  = network_profile.value.network_data_plane
      dns_service_ip      = network_profile.value.dns_service_ip
      service_cidr        = network_profile.value.service_cidr
      pod_cidr            = network_profile.value.pod_cidr
      outbound_type       = network_profile.value.outbound_type
      load_balancer_sku   = network_profile.value.load_balancer_sku

      dynamic "load_balancer_profile" {
        for_each = network_profile.value.load_balancer_profile != null ? [network_profile.value.load_balancer_profile] : []
        content {
          managed_outbound_ip_count   = load_balancer_profile.value.managed_outbound_ip_count
          managed_outbound_ipv6_count = load_balancer_profile.value.managed_outbound_ipv6_count
          outbound_ip_address_ids     = load_balancer_profile.value.outbound_ip_address_ids
          outbound_ip_prefix_ids      = load_balancer_profile.value.outbound_ip_prefix_ids
          outbound_ports_allocated    = load_balancer_profile.value.outbound_ports_allocated
          idle_timeout_in_minutes     = load_balancer_profile.value.idle_timeout_in_minutes
        }
      }
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.azure_active_directory_role_based_access_control != null ? [var.azure_active_directory_role_based_access_control] : []
    content {
      tenant_id              = azure_active_directory_role_based_access_control.value.tenant_id
      admin_group_object_ids = azure_active_directory_role_based_access_control.value.admin_group_object_ids
      azure_rbac_enabled     = azure_active_directory_role_based_access_control.value.azure_rbac_enabled
    }
  }

  dynamic "oms_agent" {
    for_each = var.oms_agent != null ? [var.oms_agent] : []
    content {
      log_analytics_workspace_id      = oms_agent.value.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = oms_agent.value.msi_auth_for_monitoring_enabled
    }
  }

  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender != null ? [var.microsoft_defender] : []
    content {
      log_analytics_workspace_id = microsoft_defender.value.log_analytics_workspace_id
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider != null ? [var.key_vault_secrets_provider] : []
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.api_server_access_profile != null ? [var.api_server_access_profile] : []
    content {
      authorized_ip_ranges                = api_server_access_profile.value.authorized_ip_ranges
      subnet_id                           = api_server_access_profile.value.subnet_id
      virtual_network_integration_enabled = api_server_access_profile.value.virtual_network_integration_enabled
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile != null ? [var.auto_scaler_profile] : []
    content {
      balance_similar_node_groups      = auto_scaler_profile.value.balance_similar_node_groups
      expander                         = auto_scaler_profile.value.expander
      max_graceful_termination_sec     = auto_scaler_profile.value.max_graceful_termination_sec
      max_node_provisioning_time       = auto_scaler_profile.value.max_node_provisioning_time
      max_unready_nodes                = auto_scaler_profile.value.max_unready_nodes
      max_unready_percentage           = auto_scaler_profile.value.max_unready_percentage
      new_pod_scale_up_delay           = auto_scaler_profile.value.new_pod_scale_up_delay
      scale_down_delay_after_add       = auto_scaler_profile.value.scale_down_delay_after_add
      scale_down_delay_after_delete    = auto_scaler_profile.value.scale_down_delay_after_delete
      scale_down_delay_after_failure   = auto_scaler_profile.value.scale_down_delay_after_failure
      scan_interval                    = auto_scaler_profile.value.scan_interval
      scale_down_unneeded              = auto_scaler_profile.value.scale_down_unneeded
      scale_down_unready               = auto_scaler_profile.value.scale_down_unready
      scale_down_utilization_threshold = auto_scaler_profile.value.scale_down_utilization_threshold
      empty_bulk_delete_max            = auto_scaler_profile.value.empty_bulk_delete_max
      skip_nodes_with_local_storage    = auto_scaler_profile.value.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = auto_scaler_profile.value.skip_nodes_with_system_pods
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      dynamic "allowed" {
        for_each = maintenance_window.value.allowed
        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = maintenance_window.value.not_allowed
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = var.maintenance_window_auto_upgrade != null ? [var.maintenance_window_auto_upgrade] : []
    content {
      frequency    = maintenance_window_auto_upgrade.value.frequency
      interval     = maintenance_window_auto_upgrade.value.interval
      duration     = maintenance_window_auto_upgrade.value.duration
      day_of_week  = maintenance_window_auto_upgrade.value.day_of_week
      day_of_month = maintenance_window_auto_upgrade.value.day_of_month
      week_index   = maintenance_window_auto_upgrade.value.week_index
      start_time   = maintenance_window_auto_upgrade.value.start_time
      utc_offset   = maintenance_window_auto_upgrade.value.utc_offset
      start_date   = maintenance_window_auto_upgrade.value.start_date
      dynamic "not_allowed" {
        for_each = maintenance_window_auto_upgrade.value.not_allowed
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = var.maintenance_window_node_os != null ? [var.maintenance_window_node_os] : []
    content {
      frequency    = maintenance_window_node_os.value.frequency
      interval     = maintenance_window_node_os.value.interval
      duration     = maintenance_window_node_os.value.duration
      day_of_week  = maintenance_window_node_os.value.day_of_week
      day_of_month = maintenance_window_node_os.value.day_of_month
      week_index   = maintenance_window_node_os.value.week_index
      start_time   = maintenance_window_node_os.value.start_time
      utc_offset   = maintenance_window_node_os.value.utc_offset
      start_date   = maintenance_window_node_os.value.start_date
      dynamic "not_allowed" {
        for_each = maintenance_window_node_os.value.not_allowed
        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "storage_profile" {
    for_each = var.storage_profile != null ? [var.storage_profile] : []
    content {
      blob_driver_enabled         = storage_profile.value.blob_driver_enabled
      disk_driver_enabled         = storage_profile.value.disk_driver_enabled
      file_driver_enabled         = storage_profile.value.file_driver_enabled
      snapshot_controller_enabled = storage_profile.value.snapshot_controller_enabled
    }
  }

  dynamic "linux_profile" {
    for_each = var.linux_profile != null ? [var.linux_profile] : []
    content {
      admin_username = linux_profile.value.admin_username
      ssh_key {
        key_data = linux_profile.value.ssh_key.key_data
      }
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = var.workload_autoscaler_profile != null ? [var.workload_autoscaler_profile] : []
    content {
      keda_enabled                    = workload_autoscaler_profile.value.keda_enabled
      vertical_pod_autoscaler_enabled = workload_autoscaler_profile.value.vertical_pod_autoscaler_enabled
    }
  }

  dynamic "http_proxy_config" {
    for_each = var.http_proxy_config != null ? [var.http_proxy_config] : []
    content {
      http_proxy  = http_proxy_config.value.http_proxy
      https_proxy = http_proxy_config.value.https_proxy
      no_proxy    = http_proxy_config.value.no_proxy
      trusted_ca  = http_proxy_config.value.trusted_ca
    }
  }

  lifecycle {
    ignore_changes = [
      // Azure auto-upgrades kubernetes_version outside Terraform
      kubernetes_version,
      // Cluster autoscaler modifies node_count externally
      default_node_pool[0].node_count,
    ]
  }

  timeouts {
    create = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster"]["create"],
      local.metadata.resource_timeouts["default"]["create"]
    )
    read = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster"]["read"],
      local.metadata.resource_timeouts["default"]["read"]
    )
    update = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster"]["update"],
      local.metadata.resource_timeouts["default"]["update"]
    )
    delete = try(
      local.metadata.resource_timeouts["azurerm_kubernetes_cluster"]["delete"],
      local.metadata.resource_timeouts["default"]["delete"]
    )
  }
}
