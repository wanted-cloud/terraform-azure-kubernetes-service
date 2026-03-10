variable "name" {
  description = "Name of the AKS cluster resource."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the AKS cluster will be created."
  type        = string
}

variable "location" {
  description = "Location in which the AKS cluster will be created. If not set it will be the same as the resource group."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be applied to the AKS cluster resources."
  type        = map(string)
  default     = {}
}

variable "dns_prefix" {
  description = "DNS prefix for the Azure Kubernetes Service. If not set it will be derived from the cluster name."
  type        = string
  default     = null
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the AKS cluster. If not set the latest available version will be used."
  type        = string
  default     = null
}

variable "automatic_upgrade_channel" {
  description = "Automatic upgrade channel for the AKS cluster. Possible values are patch, rapid, node-image, stable, or none."
  type        = string
  default     = null
}

variable "node_os_upgrade_channel" {
  description = "Node OS upgrade channel for the AKS cluster. Possible values are NodeImage, None, SecurityPatch, or Unmanaged."
  type        = string
  default     = "NodeImage"
}

variable "sku_tier" {
  description = "SKU tier for the Azure Kubernetes Service. Possible values are Free, Standard, or Premium."
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be one of: Free, Standard, Premium."
  }
}

variable "private_cluster_enabled" {
  description = "Whether to enable private cluster for the Azure Kubernetes Service."
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone to be used for the private cluster."
  type        = string
  default     = null
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Whether to enable public FQDN for the private cluster."
  type        = bool
  default     = false
}

variable "role_based_access_control_enabled" {
  description = "Whether to enable role-based access control for the AKS cluster."
  type        = bool
  default     = true
}

variable "local_account_disabled" {
  description = "Whether to disable local accounts on the AKS cluster."
  type        = bool
  default     = false
}

variable "workload_identity_enabled" {
  description = "Whether to enable workload identity for the AKS cluster."
  type        = bool
  default     = false
}

variable "oidc_issuer_enabled" {
  description = "Whether to enable OIDC issuer for the AKS cluster."
  type        = bool
  default     = false
}

variable "identity_type" {
  description = "Type of identity to use for the AKS cluster."
  type        = string
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity_type)
    error_message = "identity_type must be one of: SystemAssigned, UserAssigned, \"SystemAssigned, UserAssigned\"."
  }
}

variable "user_assigned_identity_ids" {
  description = "List of user assigned identity IDs for the AKS cluster."
  type        = list(string)
  default     = []
}

variable "default_node_pool" {
  description = "Configuration for the default node pool."
  type = object({
    name      = string
    vm_size   = string
    subnet_id = optional(string, null)
    tags      = optional(map(string), {})
    os_sku    = optional(string, "AzureLinux")
    zones     = optional(list(number), [])

    // Auto-scaling flag
    auto_scaling_enabled = optional(bool, false)
    // Auto-scaling configuration
    max_count  = optional(number, null)
    min_count  = optional(number, null)
    node_count = optional(number, null)

    max_pods                     = optional(number, null)
    node_labels                  = optional(map(string), null)
    only_critical_addons_enabled = optional(bool, null)
    orchestrator_version         = optional(string, null)
    os_disk_size_gb              = optional(number, null)
    os_disk_type                 = optional(string, null)
    type                         = optional(string, null)
    scale_down_mode              = optional(string, null)
    pod_subnet_id                = optional(string, null)
    node_public_ip_enabled       = optional(bool, null)
    temporary_name_for_rotation  = optional(string, null)

    upgrade_settings = optional(object({
      drain_timeout_in_minutes      = optional(number, null)
      node_soak_duration_in_minutes = optional(number, null)
      max_surge                     = optional(string, "10%")
    }), null)

    kubelet_config = optional(object({
      cpu_manager_policy        = optional(string, null)
      cpu_cfs_quota_enabled     = optional(bool, null)
      cpu_cfs_quota_period      = optional(string, null)
      image_gc_high_threshold   = optional(number, null)
      image_gc_low_threshold    = optional(number, null)
      topology_manager_policy   = optional(string, null)
      allowed_unsafe_sysctls    = optional(list(string), null)
      container_log_max_size_mb = optional(number, null)
      container_log_max_line    = optional(number, null)
      pod_max_pid               = optional(number, null)
    }), null)

    linux_os_config = optional(object({
      swap_file_size_mb             = optional(number, null)
      transparent_huge_page_enabled = optional(string, null)
      transparent_huge_page_defrag  = optional(string, null)
      sysctl_config = optional(object({
        fs_aio_max_nr                      = optional(number, null)
        fs_file_max                        = optional(number, null)
        fs_inotify_max_user_watches        = optional(number, null)
        fs_nr_open                         = optional(number, null)
        kernel_threads_max                 = optional(number, null)
        net_core_netdev_max_backlog        = optional(number, null)
        net_core_optmem_max                = optional(number, null)
        net_core_rmem_default              = optional(number, null)
        net_core_rmem_max                  = optional(number, null)
        net_core_somaxconn                 = optional(number, null)
        net_core_wmem_default              = optional(number, null)
        net_core_wmem_max                  = optional(number, null)
        net_ipv4_ip_local_port_range_max   = optional(number, null)
        net_ipv4_ip_local_port_range_min   = optional(number, null)
        net_ipv4_neigh_default_gc_thresh1  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh2  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh3  = optional(number, null)
        net_ipv4_tcp_fin_timeout           = optional(number, null)
        net_ipv4_tcp_keepalive_intvl       = optional(number, null)
        net_ipv4_tcp_keepalive_probes      = optional(number, null)
        net_ipv4_tcp_keepalive_time        = optional(number, null)
        net_ipv4_tcp_max_syn_backlog       = optional(number, null)
        net_ipv4_tcp_max_tw_buckets        = optional(number, null)
        net_ipv4_tcp_tw_reuse              = optional(bool, null)
        net_netfilter_nf_conntrack_buckets = optional(number, null)
        net_netfilter_nf_conntrack_max     = optional(number, null)
        vm_max_map_count                   = optional(number, null)
        vm_swappiness                      = optional(number, null)
        vm_vfs_cache_pressure              = optional(number, null)
      }), null)
    }), null)
  })

  validation {
    condition = (
      var.default_node_pool.auto_scaling_enabled == true
      ? (var.default_node_pool.min_count != null && var.default_node_pool.max_count != null)
      : var.default_node_pool.node_count != null
    )
    error_message = "When auto_scaling_enabled is true, min_count and max_count must be set. When auto_scaling_enabled is false, node_count must be set."
  }
}

variable "additional_node_pools" {
  description = "List of additional node pools to be created."
  type = list(object({
    name      = string
    vm_size   = string
    subnet_id = optional(string, null)
    tags      = optional(map(string), {})
    os_type   = optional(string, "Linux")
    os_sku    = optional(string, "AzureLinux")
    priority  = optional(string, "Regular")
    zones     = optional(list(number), [])

    // Auto-scaling flag
    auto_scaling_enabled = optional(bool, false)
    // Auto-scaling configuration
    max_count  = optional(number, null)
    min_count  = optional(number, null)
    node_count = optional(number, null)

    node_labels          = optional(map(string), null)
    node_taints          = optional(list(string), null)
    max_pods             = optional(number, null)
    orchestrator_version = optional(string, null)
    os_disk_size_gb      = optional(number, null)
    os_disk_type         = optional(string, null)
    mode                 = optional(string, "User")
    scale_down_mode      = optional(string, null)
    eviction_policy      = optional(string, null)
    spot_max_price       = optional(number, null)
    pod_subnet_id        = optional(string, null)

    node_public_ip_enabled      = optional(bool, null)
    host_encryption_enabled     = optional(bool, null)
    fips_enabled                = optional(bool, null)
    temporary_name_for_rotation = optional(string, null)

    upgrade_settings = optional(object({
      drain_timeout_in_minutes      = optional(number, null)
      node_soak_duration_in_minutes = optional(number, null)
      max_surge                     = optional(string, "10%")
    }), null)

    kubelet_config = optional(object({
      cpu_manager_policy        = optional(string, null)
      cpu_cfs_quota_enabled     = optional(bool, null)
      cpu_cfs_quota_period      = optional(string, null)
      image_gc_high_threshold   = optional(number, null)
      image_gc_low_threshold    = optional(number, null)
      topology_manager_policy   = optional(string, null)
      allowed_unsafe_sysctls    = optional(list(string), null)
      container_log_max_size_mb = optional(number, null)
      container_log_max_line    = optional(number, null)
      pod_max_pid               = optional(number, null)
    }), null)

    linux_os_config = optional(object({
      swap_file_size_mb             = optional(number, null)
      transparent_huge_page_enabled = optional(string, null)
      transparent_huge_page_defrag  = optional(string, null)
      sysctl_config = optional(object({
        fs_aio_max_nr                      = optional(number, null)
        fs_file_max                        = optional(number, null)
        fs_inotify_max_user_watches        = optional(number, null)
        fs_nr_open                         = optional(number, null)
        kernel_threads_max                 = optional(number, null)
        net_core_netdev_max_backlog        = optional(number, null)
        net_core_optmem_max                = optional(number, null)
        net_core_rmem_default              = optional(number, null)
        net_core_rmem_max                  = optional(number, null)
        net_core_somaxconn                 = optional(number, null)
        net_core_wmem_default              = optional(number, null)
        net_core_wmem_max                  = optional(number, null)
        net_ipv4_ip_local_port_range_max   = optional(number, null)
        net_ipv4_ip_local_port_range_min   = optional(number, null)
        net_ipv4_neigh_default_gc_thresh1  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh2  = optional(number, null)
        net_ipv4_neigh_default_gc_thresh3  = optional(number, null)
        net_ipv4_tcp_fin_timeout           = optional(number, null)
        net_ipv4_tcp_keepalive_intvl       = optional(number, null)
        net_ipv4_tcp_keepalive_probes      = optional(number, null)
        net_ipv4_tcp_keepalive_time        = optional(number, null)
        net_ipv4_tcp_max_syn_backlog       = optional(number, null)
        net_ipv4_tcp_max_tw_buckets        = optional(number, null)
        net_ipv4_tcp_tw_reuse              = optional(bool, null)
        net_netfilter_nf_conntrack_buckets = optional(number, null)
        net_netfilter_nf_conntrack_max     = optional(number, null)
        vm_max_map_count                   = optional(number, null)
        vm_swappiness                      = optional(number, null)
        vm_vfs_cache_pressure              = optional(number, null)
      }), null)
    }), null)

    node_network_profile = optional(object({
      allowed_host_ports = optional(list(object({
        port_start = optional(number, null)
        port_end   = optional(number, null)
        protocol   = optional(string, null)
      })), [])
      application_security_group_ids = optional(list(string), [])
      node_public_ip_tags            = optional(map(string), {})
    }), null)

    windows_profile = optional(object({
      outbound_nat_enabled = optional(bool, true)
    }), null)
  }))
  default = []

  validation {
    condition = alltrue([
      for pool in var.additional_node_pools :
      pool.auto_scaling_enabled == true
      ? (pool.min_count != null && pool.max_count != null)
      : pool.node_count != null
    ])
    error_message = "For each additional node pool: when auto_scaling_enabled is true, min_count and max_count must be set. When auto_scaling_enabled is false, node_count must be set."
  }

  validation {
    condition = alltrue([
      for pool in var.additional_node_pools :
      pool.priority == "Spot" ? pool.eviction_policy != null : true
    ])
    error_message = "For each additional node pool with priority=Spot, eviction_policy must be set."
  }
}

variable "network_profile" {
  description = "Network profile configuration for the AKS cluster."
  type = object({
    network_plugin      = optional(string, "azure")
    network_policy      = optional(string, null)
    network_plugin_mode = optional(string, null)
    network_data_plane  = optional(string, null)
    dns_service_ip      = optional(string, null)
    service_cidr        = optional(string, null)
    pod_cidr            = optional(string, null)
    outbound_type       = optional(string, "loadBalancer")
    load_balancer_sku   = optional(string, "standard")
    load_balancer_profile = optional(object({
      managed_outbound_ip_count   = optional(number, null)
      managed_outbound_ipv6_count = optional(number, null)
      outbound_ip_address_ids     = optional(list(string), null)
      outbound_ip_prefix_ids      = optional(list(string), null)
      outbound_ports_allocated    = optional(number, null)
      idle_timeout_in_minutes     = optional(number, null)
    }), null)
  })
  default = null
}

variable "azure_active_directory_role_based_access_control" {
  description = "Azure Active Directory role-based access control configuration for the AKS cluster."
  type = object({
    tenant_id              = optional(string, null)
    admin_group_object_ids = optional(list(string), [])
    azure_rbac_enabled     = optional(bool, false)
  })
  default = null
}

variable "oms_agent" {
  description = "OMS agent configuration for the AKS cluster."
  type = object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool, true)
  })
  default = null
}

variable "microsoft_defender" {
  description = "Microsoft Defender configuration for the AKS cluster."
  type = object({
    log_analytics_workspace_id = string
  })
  default = null
}

variable "key_vault_secrets_provider" {
  description = "Key Vault secrets provider configuration for the AKS cluster."
  type = object({
    secret_rotation_enabled  = optional(bool, false)
    secret_rotation_interval = optional(string, "2m")
  })
  default = null
}

variable "api_server_access_profile" {
  description = "API server access profile configuration for the AKS cluster."
  type = object({
    authorized_ip_ranges                = optional(list(string), null)
    subnet_id                           = optional(string, null)
    virtual_network_integration_enabled = optional(bool, false)
  })
  default = null
}

variable "auto_scaler_profile" {
  description = "Auto scaler profile configuration for the AKS cluster."
  type = object({
    balance_similar_node_groups      = optional(bool, false)
    expander                         = optional(string, "random")
    max_graceful_termination_sec     = optional(number, 600)
    max_node_provisioning_time       = optional(string, "15m")
    max_unready_nodes                = optional(number, 3)
    max_unready_percentage           = optional(number, 45)
    new_pod_scale_up_delay           = optional(string, "10s")
    scale_down_delay_after_add       = optional(string, "10m")
    scale_down_delay_after_delete    = optional(string, "10s")
    scale_down_delay_after_failure   = optional(string, "3m")
    scan_interval                    = optional(string, "10s")
    scale_down_unneeded              = optional(string, "10m")
    scale_down_unready               = optional(string, "20m")
    scale_down_utilization_threshold = optional(number, 0.5)
    empty_bulk_delete_max            = optional(number, 10)
    skip_nodes_with_local_storage    = optional(bool, true)
    skip_nodes_with_system_pods      = optional(bool, true)
  })
  default = null
}

variable "maintenance_window" {
  description = "Maintenance window configuration for the AKS cluster."
  type = object({
    allowed = optional(list(object({
      day   = string
      hours = list(number)
    })), [])
    not_allowed = optional(list(object({
      start = string
      end   = string
    })), [])
  })
  default = null
}

variable "maintenance_window_auto_upgrade" {
  description = "Maintenance window auto upgrade configuration for the AKS cluster."
  type = object({
    frequency    = string
    interval     = number
    duration     = number
    day_of_week  = optional(string, null)
    day_of_month = optional(number, null)
    week_index   = optional(string, null)
    start_time   = optional(string, null)
    utc_offset   = optional(string, "+00:00")
    start_date   = optional(string, null)
    not_allowed = optional(list(object({
      start = string
      end   = string
    })), [])
  })
  default = null
}

variable "maintenance_window_node_os" {
  description = "Maintenance window node OS configuration for the AKS cluster."
  type = object({
    frequency    = string
    interval     = number
    duration     = number
    day_of_week  = optional(string, null)
    day_of_month = optional(number, null)
    week_index   = optional(string, null)
    start_time   = optional(string, null)
    utc_offset   = optional(string, "+00:00")
    start_date   = optional(string, null)
    not_allowed = optional(list(object({
      start = string
      end   = string
    })), [])
  })
  default = null
}

variable "storage_profile" {
  description = "Storage profile configuration for the AKS cluster."
  type = object({
    blob_driver_enabled         = optional(bool, false)
    disk_driver_enabled         = optional(bool, true)
    file_driver_enabled         = optional(bool, true)
    snapshot_controller_enabled = optional(bool, true)
  })
  default = null
}

variable "linux_profile" {
  description = "Linux profile configuration for the AKS cluster."
  type = object({
    admin_username = string
    ssh_key = object({
      key_data = string
    })
  })
  default = null
}

variable "workload_autoscaler_profile" {
  description = "Workload autoscaler profile configuration for the AKS cluster."
  type = object({
    keda_enabled                    = optional(bool, false)
    vertical_pod_autoscaler_enabled = optional(bool, false)
  })
  default = null
}

variable "http_proxy_config" {
  description = "HTTP proxy configuration for the AKS cluster."
  type = object({
    http_proxy  = optional(string, null)
    https_proxy = optional(string, null)
    no_proxy    = optional(list(string), [])
    trusted_ca  = optional(string, null)
  })
  default = null
}
