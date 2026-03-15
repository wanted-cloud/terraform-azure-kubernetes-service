<!-- BEGIN_TF_DOCS -->
# wanted-cloud/terraform-azure-kubernetes-service

Terraform building block managing Azure Kubernetes Service and related resources.

## Table of contents

- [Requirements](#requirements)
- [Providers](#providers)
- [Variables](#inputs)
- [Outputs](#outputs)
- [Resources](#resources)
- [Usage](#usage)
- [Contributing](#contributing)

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>=4.20.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (4.63.0)

## Required Inputs

The following input variables are required:

### <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool)

Description: Configuration for the default node pool.

Type:

```hcl
object({
    name      = string
    vm_size   = string
    subnet_id = optional(string, null)
    tags      = optional(map(string), {})
    os_sku    = optional(string, "AzureLinux")
    zones     = optional(list(string), [])

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

    capacity_reservation_group_id = optional(string, null)
    gpu_driver                    = optional(string, null)
    gpu_instance                  = optional(string, null)
    host_group_id                 = optional(string, null)
    host_encryption_enabled       = optional(bool, null)
    fips_enabled                  = optional(bool, null)
    kubelet_disk_type             = optional(string, null)
    node_public_ip_prefix_id      = optional(string, null)
    proximity_placement_group_id  = optional(string, null)
    snapshot_id                   = optional(string, null)
    ultra_ssd_enabled             = optional(bool, null)
    workload_runtime              = optional(string, null)

    upgrade_settings = optional(object({
      drain_timeout_in_minutes      = optional(number, null)
      node_soak_duration_in_minutes = optional(number, null)
      max_surge                     = optional(string, "10%")
      undrainable_node_behavior     = optional(string, null)
    }), null)

    kubelet_config = optional(object({
      cpu_manager_policy        = optional(string, null)
      cpu_cfs_quota_enabled     = optional(bool, null)
      cpu_cfs_quota_period      = optional(string, null)
      image_gc_high_threshold   = optional(number, null)
      image_gc_low_threshold    = optional(number, null)
      topology_manager_policy   = optional(string, null)
      allowed_unsafe_sysctls    = optional(list(string), null)
      container_log_max_size_mb = optional(string, null)
      container_log_max_line    = optional(number, null)
      pod_max_pid               = optional(number, null)
    }), null)

    linux_os_config = optional(object({
      swap_file_size_mb            = optional(number, null)
      transparent_huge_page        = optional(string, null)
      transparent_huge_page_defrag = optional(string, null)
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
  })
```

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the AKS cluster resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Name of the resource group in which the AKS cluster will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_aci_connector_linux"></a> [aci\_connector\_linux](#input\_aci\_connector\_linux)

Description: ACI connector Linux configuration for the AKS cluster (virtual nodes add-on).

Type:

```hcl
object({
    subnet_name = string
  })
```

Default: `null`

### <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools)

Description: List of additional node pools to be created.

Type:

```hcl
list(object({
    name      = string
    vm_size   = string
    subnet_id = optional(string, null)
    tags      = optional(map(string), {})
    os_type   = optional(string, "Linux")
    os_sku    = optional(string, "AzureLinux")
    priority  = optional(string, "Regular")
    zones     = optional(list(string), [])

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
      undrainable_node_behavior     = optional(string, null)
    }), null)

    kubelet_config = optional(object({
      cpu_manager_policy        = optional(string, null)
      cpu_cfs_quota_enabled     = optional(bool, null)
      cpu_cfs_quota_period      = optional(string, null)
      image_gc_high_threshold   = optional(number, null)
      image_gc_low_threshold    = optional(number, null)
      topology_manager_policy   = optional(string, null)
      allowed_unsafe_sysctls    = optional(list(string), null)
      container_log_max_size_mb = optional(string, null)
      container_log_max_line    = optional(number, null)
      pod_max_pid               = optional(number, null)
    }), null)

    linux_os_config = optional(object({
      swap_file_size_mb            = optional(number, null)
      transparent_huge_page        = optional(string, null)
      transparent_huge_page_defrag = optional(string, null)
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
```

Default: `[]`

### <a name="input_ai_toolchain_operator_enabled"></a> [ai\_toolchain\_operator\_enabled](#input\_ai\_toolchain\_operator\_enabled)

Description: Whether to enable the AI toolchain operator on the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_api_server_access_profile"></a> [api\_server\_access\_profile](#input\_api\_server\_access\_profile)

Description: API server access profile configuration for the AKS cluster.

Type:

```hcl
object({
    authorized_ip_ranges                = optional(list(string), null)
    subnet_id                           = optional(string, null)
    virtual_network_integration_enabled = optional(bool, false)
  })
```

Default: `null`

### <a name="input_auto_scaler_profile"></a> [auto\_scaler\_profile](#input\_auto\_scaler\_profile)

Description: Auto scaler profile configuration for the AKS cluster.

Type:

```hcl
object({
    balance_similar_node_groups                   = optional(bool, false)
    expander                                      = optional(string, "random")
    max_graceful_termination_sec                  = optional(number, 600)
    max_node_provisioning_time                    = optional(string, "15m")
    max_unready_nodes                             = optional(number, 3)
    max_unready_percentage                        = optional(number, 45)
    new_pod_scale_up_delay                        = optional(string, "10s")
    scale_down_delay_after_add                    = optional(string, "10m")
    scale_down_delay_after_delete                 = optional(string, "10s")
    scale_down_delay_after_failure                = optional(string, "3m")
    scan_interval                                 = optional(string, "10s")
    scale_down_unneeded                           = optional(string, "10m")
    scale_down_unready                            = optional(string, "20m")
    scale_down_utilization_threshold              = optional(number, 0.5)
    empty_bulk_delete_max                         = optional(number, 10)
    skip_nodes_with_local_storage                 = optional(bool, true)
    skip_nodes_with_system_pods                   = optional(bool, true)
    daemonset_eviction_for_empty_nodes_enabled    = optional(bool, null)
    daemonset_eviction_for_occupied_nodes_enabled = optional(bool, null)
    ignore_daemonsets_utilization_enabled         = optional(bool, null)
  })
```

Default: `null`

### <a name="input_automatic_upgrade_channel"></a> [automatic\_upgrade\_channel](#input\_automatic\_upgrade\_channel)

Description: Automatic upgrade channel for the AKS cluster. Possible values are patch, rapid, node-image, stable, or none.

Type: `string`

Default: `null`

### <a name="input_azure_active_directory_role_based_access_control"></a> [azure\_active\_directory\_role\_based\_access\_control](#input\_azure\_active\_directory\_role\_based\_access\_control)

Description: Azure Active Directory role-based access control configuration for the AKS cluster.

Type:

```hcl
object({
    tenant_id              = optional(string, null)
    admin_group_object_ids = optional(list(string), [])
    azure_rbac_enabled     = optional(bool, false)
  })
```

Default: `null`

### <a name="input_azure_policy_enabled"></a> [azure\_policy\_enabled](#input\_azure\_policy\_enabled)

Description: Whether to enable the Azure Policy add-on for the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_bootstrap_profile"></a> [bootstrap\_profile](#input\_bootstrap\_profile)

Description: Bootstrap profile configuration for the AKS cluster.

Type:

```hcl
object({
    artifact_source       = optional(string, null)
    container_registry_id = optional(string, null)
  })
```

Default: `null`

### <a name="input_confidential_computing"></a> [confidential\_computing](#input\_confidential\_computing)

Description: Confidential computing configuration for the AKS cluster.

Type:

```hcl
object({
    sgx_quote_helper_enabled = bool
  })
```

Default: `null`

### <a name="input_cost_analysis_enabled"></a> [cost\_analysis\_enabled](#input\_cost\_analysis\_enabled)

Description: Whether to enable cost analysis for the AKS cluster. Requires sku\_tier to be Standard or Premium.

Type: `bool`

Default: `false`

### <a name="input_custom_ca_trust_certificates_base64"></a> [custom\_ca\_trust\_certificates\_base64](#input\_custom\_ca\_trust\_certificates\_base64)

Description: List of up to 10 base64-encoded CA certificates to be added to the trust store of nodes.

Type: `list(string)`

Default: `[]`

### <a name="input_disk_encryption_set_id"></a> [disk\_encryption\_set\_id](#input\_disk\_encryption\_set\_id)

Description: The ID of the Disk Encryption Set to use for encrypting the OS disk of nodes.

Type: `string`

Default: `null`

### <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix)

Description: DNS prefix for the Azure Kubernetes Service. If not set it will be derived from the cluster name.

Type: `string`

Default: `null`

### <a name="input_dns_prefix_private_cluster"></a> [dns\_prefix\_private\_cluster](#input\_dns\_prefix\_private\_cluster)

Description: Specifies the DNS prefix to use with the private cluster FQDN. Changing this forces a new resource.

Type: `string`

Default: `null`

### <a name="input_edge_zone"></a> [edge\_zone](#input\_edge\_zone)

Description: Specifies the extended availability zone in which the AKS cluster will be created.

Type: `string`

Default: `null`

### <a name="input_http_application_routing_enabled"></a> [http\_application\_routing\_enabled](#input\_http\_application\_routing\_enabled)

Description: Whether HTTP Application Routing is enabled.

Type: `bool`

Default: `false`

### <a name="input_http_proxy_config"></a> [http\_proxy\_config](#input\_http\_proxy\_config)

Description: HTTP proxy configuration for the AKS cluster.

Type:

```hcl
object({
    http_proxy  = optional(string, null)
    https_proxy = optional(string, null)
    no_proxy    = optional(list(string), [])
    trusted_ca  = optional(string, null)
  })
```

Default: `null`

### <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type)

Description: Type of identity to use for the AKS cluster.

Type: `string`

Default: `"SystemAssigned"`

### <a name="input_image_cleaner_enabled"></a> [image\_cleaner\_enabled](#input\_image\_cleaner\_enabled)

Description: Whether to enable the Image Cleaner on the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_image_cleaner_interval_hours"></a> [image\_cleaner\_interval\_hours](#input\_image\_cleaner\_interval\_hours)

Description: Specifies the interval in hours when images should be cleaned up. Ranges from 24 to 2160.

Type: `number`

Default: `null`

### <a name="input_ingress_application_gateway"></a> [ingress\_application\_gateway](#input\_ingress\_application\_gateway)

Description: Ingress Application Gateway add-on configuration for the AKS cluster.

Type:

```hcl
object({
    gateway_id   = optional(string, null)
    gateway_name = optional(string, null)
    subnet_cidr  = optional(string, null)
    subnet_id    = optional(string, null)
  })
```

Default: `null`

### <a name="input_key_management_service"></a> [key\_management\_service](#input\_key\_management\_service)

Description: Key Management Service (Azure KMS etcd encryption) configuration for the AKS cluster.

Type:

```hcl
object({
    key_vault_key_id         = string
    key_vault_network_access = optional(string, null)
  })
```

Default: `null`

### <a name="input_key_vault_secrets_provider"></a> [key\_vault\_secrets\_provider](#input\_key\_vault\_secrets\_provider)

Description: Key Vault secrets provider configuration for the AKS cluster.

Type:

```hcl
object({
    secret_rotation_enabled  = optional(bool, false)
    secret_rotation_interval = optional(string, "2m")
  })
```

Default: `null`

### <a name="input_kubelet_identity"></a> [kubelet\_identity](#input\_kubelet\_identity)

Description: User-assigned identity for the kubelet to authenticate to Azure resources.

Type:

```hcl
object({
    client_id                 = optional(string, null)
    object_id                 = optional(string, null)
    user_assigned_identity_id = optional(string, null)
  })
```

Default: `null`

### <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version)

Description: Kubernetes version to use for the AKS cluster. If not set the latest available version will be used.

Type: `string`

Default: `null`

### <a name="input_linux_profile"></a> [linux\_profile](#input\_linux\_profile)

Description: Linux profile configuration for the AKS cluster.

Type:

```hcl
object({
    admin_username = string
    ssh_key = object({
      key_data = string
    })
  })
```

Default: `null`

### <a name="input_local_account_disabled"></a> [local\_account\_disabled](#input\_local\_account\_disabled)

Description: Whether to disable local accounts on the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_location"></a> [location](#input\_location)

Description: Location in which the AKS cluster will be created. If not set it will be the same as the resource group.

Type: `string`

Default: `null`

### <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window)

Description: Maintenance window configuration for the AKS cluster.

Type:

```hcl
object({
    allowed = optional(list(object({
      day   = string
      hours = list(number)
    })), [])
    not_allowed = optional(list(object({
      start = string
      end   = string
    })), [])
  })
```

Default: `null`

### <a name="input_maintenance_window_auto_upgrade"></a> [maintenance\_window\_auto\_upgrade](#input\_maintenance\_window\_auto\_upgrade)

Description: Maintenance window auto upgrade configuration for the AKS cluster.

Type:

```hcl
object({
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
```

Default: `null`

### <a name="input_maintenance_window_node_os"></a> [maintenance\_window\_node\_os](#input\_maintenance\_window\_node\_os)

Description: Maintenance window node OS configuration for the AKS cluster.

Type:

```hcl
object({
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
```

Default: `null`

### <a name="input_metadata"></a> [metadata](#input\_metadata)

Description: Metadata definitions for the module, this is optional construct allowing override of the module defaults defintions of validation expressions, error messages, resource timeouts and default tags.

Type:

```hcl
object({
    resource_timeouts = optional(
      map(
        object({
          create = optional(string, "30m")
          read   = optional(string, "5m")
          update = optional(string, "30m")
          delete = optional(string, "30m")
        })
      ), {}
    )
    tags                     = optional(map(string), {})
    validator_error_messages = optional(map(string), {})
    validator_expressions    = optional(map(string), {})
  })
```

Default: `{}`

### <a name="input_microsoft_defender"></a> [microsoft\_defender](#input\_microsoft\_defender)

Description: Microsoft Defender configuration for the AKS cluster.

Type:

```hcl
object({
    log_analytics_workspace_id = string
  })
```

Default: `null`

### <a name="input_monitor_metrics"></a> [monitor\_metrics](#input\_monitor\_metrics)

Description: Metrics configuration for the Azure Monitor managed Prometheus add-on.

Type:

```hcl
object({
    annotations_allowed = optional(string, null)
    labels_allowed      = optional(string, null)
  })
```

Default: `null`

### <a name="input_network_profile"></a> [network\_profile](#input\_network\_profile)

Description: Network profile configuration for the AKS cluster.

Type:

```hcl
object({
    network_plugin      = optional(string, "azure")
    network_policy      = optional(string, null)
    network_plugin_mode = optional(string, null)
    network_data_plane  = optional(string, null)
    network_mode        = optional(string, null)
    dns_service_ip      = optional(string, null)
    service_cidr        = optional(string, null)
    pod_cidr            = optional(string, null)
    pod_cidrs           = optional(list(string), null)
    service_cidrs       = optional(list(string), null)
    ip_versions         = optional(list(string), null)
    outbound_type       = optional(string, "loadBalancer")
    load_balancer_sku   = optional(string, "standard")
    load_balancer_profile = optional(object({
      managed_outbound_ip_count   = optional(number, null)
      managed_outbound_ipv6_count = optional(number, null)
      outbound_ip_address_ids     = optional(list(string), null)
      outbound_ip_prefix_ids      = optional(list(string), null)
      outbound_ports_allocated    = optional(number, null)
      idle_timeout_in_minutes     = optional(number, null)
      backend_pool_type           = optional(string, null)
    }), null)
    nat_gateway_profile = optional(object({
      idle_timeout_in_minutes   = optional(number, null)
      managed_outbound_ip_count = optional(number, null)
    }), null)
    advanced_networking = optional(object({
      observability_enabled = optional(bool, null)
      security_enabled      = optional(bool, null)
    }), null)
  })
```

Default: `null`

### <a name="input_node_os_upgrade_channel"></a> [node\_os\_upgrade\_channel](#input\_node\_os\_upgrade\_channel)

Description: Node OS upgrade channel for the AKS cluster. Possible values are NodeImage, None, SecurityPatch, or Unmanaged.

Type: `string`

Default: `"NodeImage"`

### <a name="input_node_provisioning_profile"></a> [node\_provisioning\_profile](#input\_node\_provisioning\_profile)

Description: Node provisioning profile configuration for the AKS cluster.

Type:

```hcl
object({
    default_node_pools = optional(string, null)
    mode               = optional(string, null)
  })
```

Default: `null`

### <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group)

Description: The name of the Resource Group where the Kubernetes Nodes should exist.

Type: `string`

Default: `null`

### <a name="input_oidc_issuer_enabled"></a> [oidc\_issuer\_enabled](#input\_oidc\_issuer\_enabled)

Description: Whether to enable OIDC issuer for the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_oms_agent"></a> [oms\_agent](#input\_oms\_agent)

Description: OMS agent configuration for the AKS cluster.

Type:

```hcl
object({
    log_analytics_workspace_id      = string
    msi_auth_for_monitoring_enabled = optional(bool, true)
  })
```

Default: `null`

### <a name="input_open_service_mesh_enabled"></a> [open\_service\_mesh\_enabled](#input\_open\_service\_mesh\_enabled)

Description: Whether to enable Open Service Mesh on the AKS cluster.

Type: `bool`

Default: `false`

### <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled)

Description: Whether to enable private cluster for the Azure Kubernetes Service.

Type: `bool`

Default: `false`

### <a name="input_private_cluster_public_fqdn_enabled"></a> [private\_cluster\_public\_fqdn\_enabled](#input\_private\_cluster\_public\_fqdn\_enabled)

Description: Whether to enable public FQDN for the private cluster.

Type: `bool`

Default: `false`

### <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id)

Description: ID of the private DNS zone to be used for the private cluster.

Type: `string`

Default: `null`

### <a name="input_role_based_access_control_enabled"></a> [role\_based\_access\_control\_enabled](#input\_role\_based\_access\_control\_enabled)

Description: Whether to enable role-based access control for the AKS cluster.

Type: `bool`

Default: `true`

### <a name="input_run_command_enabled"></a> [run\_command\_enabled](#input\_run\_command\_enabled)

Description: Whether to enable the Run Command feature for the AKS cluster.

Type: `bool`

Default: `true`

### <a name="input_service_mesh_profile"></a> [service\_mesh\_profile](#input\_service\_mesh\_profile)

Description: Service mesh profile configuration for the AKS cluster (Istio-based service mesh).

Type:

```hcl
object({
    mode                             = string
    revisions                        = list(string)
    internal_ingress_gateway_enabled = optional(bool, null)
    external_ingress_gateway_enabled = optional(bool, null)
    certificate_authority = optional(object({
      key_vault_id           = string
      root_cert_object_name  = string
      cert_chain_object_name = string
      cert_object_name       = string
      key_object_name        = string
    }), null)
  })
```

Default: `null`

### <a name="input_service_principal"></a> [service\_principal](#input\_service\_principal)

Description: Service principal configuration for the AKS cluster. Mutually exclusive with the identity block.

Type:

```hcl
object({
    client_id     = string
    client_secret = string
  })
```

Default: `null`

### <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier)

Description: SKU tier for the Azure Kubernetes Service. Possible values are Free, Standard, or Premium.

Type: `string`

Default: `"Standard"`

### <a name="input_storage_profile"></a> [storage\_profile](#input\_storage\_profile)

Description: Storage profile configuration for the AKS cluster.

Type:

```hcl
object({
    blob_driver_enabled         = optional(bool, false)
    disk_driver_enabled         = optional(bool, true)
    file_driver_enabled         = optional(bool, true)
    snapshot_controller_enabled = optional(bool, true)
  })
```

Default: `null`

### <a name="input_support_plan"></a> [support\_plan](#input\_support\_plan)

Description: Specifies the support plan which should be used for this Kubernetes Cluster. Possible values are KubernetesOfficial or AKSLongTermSupport.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to be applied to the AKS cluster resources.

Type: `map(string)`

Default: `{}`

### <a name="input_upgrade_override"></a> [upgrade\_override](#input\_upgrade\_override)

Description: Upgrade override configuration for the AKS cluster.

Type:

```hcl
object({
    force_upgrade_enabled = bool
    effective_until       = optional(string, null)
  })
```

Default: `null`

### <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids)

Description: List of user assigned identity IDs for the AKS cluster.

Type: `list(string)`

Default: `[]`

### <a name="input_web_app_routing"></a> [web\_app\_routing](#input\_web\_app\_routing)

Description: Web Application Routing add-on configuration for the AKS cluster.

Type:

```hcl
object({
    dns_zone_ids             = list(string)
    default_nginx_controller = optional(string, null)
  })
```

Default: `null`

### <a name="input_windows_profile"></a> [windows\_profile](#input\_windows\_profile)

Description: Windows profile configuration for the AKS cluster (cluster-level).

Type:

```hcl
object({
    admin_username = string
    admin_password = string
    license        = optional(string, null)
    gmsa = optional(object({
      dns_server  = string
      root_domain = string
    }), null)
  })
```

Default: `null`

### <a name="input_workload_autoscaler_profile"></a> [workload\_autoscaler\_profile](#input\_workload\_autoscaler\_profile)

Description: Workload autoscaler profile configuration for the AKS cluster.

Type:

```hcl
object({
    keda_enabled                    = optional(bool, false)
    vertical_pod_autoscaler_enabled = optional(bool, false)
  })
```

Default: `null`

### <a name="input_workload_identity_enabled"></a> [workload\_identity\_enabled](#input\_workload\_identity\_enabled)

Description: Whether to enable workload identity for the AKS cluster.

Type: `bool`

Default: `false`

## Outputs

The following outputs are exported:

### <a name="output_current_kubernetes_version"></a> [current\_kubernetes\_version](#output\_current\_kubernetes\_version)

Description: The current version of Kubernetes running on the cluster.

### <a name="output_fqdn"></a> [fqdn](#output\_fqdn)

Description: The FQDN of the Kubernetes cluster API server.

### <a name="output_http_application_routing_zone_name"></a> [http\_application\_routing\_zone\_name](#output\_http\_application\_routing\_zone\_name)

Description: The Zone Name of the HTTP Application Routing. Only set when http\_application\_routing\_enabled = true.

### <a name="output_identity"></a> [identity](#output\_identity)

Description: The identity block of the Kubernetes cluster.

### <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id)

Description: The principal ID of the system-assigned managed identity of the Kubernetes cluster.

### <a name="output_key_vault_secrets_provider_identity_client_id"></a> [key\_vault\_secrets\_provider\_identity\_client\_id](#output\_key\_vault\_secrets\_provider\_identity\_client\_id)

Description: The client ID of the Key Vault Secrets Provider addon identity.

### <a name="output_key_vault_secrets_provider_identity_object_id"></a> [key\_vault\_secrets\_provider\_identity\_object\_id](#output\_key\_vault\_secrets\_provider\_identity\_object\_id)

Description: The object ID of the Key Vault Secrets Provider addon identity.

### <a name="output_kube_admin_config"></a> [kube\_admin\_config](#output\_kube\_admin\_config)

Description: The admin kubeconfig block of the Kubernetes cluster. Only set when local\_account\_disabled = false.

### <a name="output_kube_admin_config_raw"></a> [kube\_admin\_config\_raw](#output\_kube\_admin\_config\_raw)

Description: The raw admin kubeconfig of the Kubernetes cluster in YAML format. Only set when local\_account\_disabled = false.

### <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config)

Description: The kubeconfig block of the Kubernetes cluster.

### <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw)

Description: The raw kubeconfig of the Kubernetes cluster in YAML format.

### <a name="output_kubelet_identity"></a> [kubelet\_identity](#output\_kubelet\_identity)

Description: The kubelet identity block of the Kubernetes cluster. Used for ACR pull role assignments.

### <a name="output_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#output\_kubernetes\_cluster\_id)

Description: The ID of the Kubernetes cluster.

### <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name)

Description: The name of the Kubernetes cluster.

### <a name="output_node_pool_ids"></a> [node\_pool\_ids](#output\_node\_pool\_ids)

Description: Map of additional node pool names to their resource IDs.

### <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group)

Description: The name of the Resource Group containing the Kubernetes cluster nodes.

### <a name="output_node_resource_group_id"></a> [node\_resource\_group\_id](#output\_node\_resource\_group\_id)

Description: The ID of the Resource Group containing the Kubernetes cluster nodes.

### <a name="output_oidc_issuer_url"></a> [oidc\_issuer\_url](#output\_oidc\_issuer\_url)

Description: The OIDC issuer URL of the Kubernetes cluster. Only set when oidc\_issuer\_enabled = true.

### <a name="output_portal_fqdn"></a> [portal\_fqdn](#output\_portal\_fqdn)

Description: The FQDN for the Azure Portal resources when private link has been enabled, which is only resolvable inside the Virtual Network used by the Kubernetes Cluster.

### <a name="output_private_fqdn"></a> [private\_fqdn](#output\_private\_fqdn)

Description: The private FQDN of the Kubernetes cluster API server. Only set when private\_cluster\_enabled = true.

## Resources

The following resources are used by this module:

- [azurerm_kubernetes_cluster.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) (resource)
- [azurerm_kubernetes_cluster_node_pool.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

## Usage

> For more detailed examples navigate to `examples` folder of this repository.

Module was also published via Terraform Registry and can be used as a module from the registry.

```hcl
module "example" {
  source  = "wanted-cloud/..."
  version = "x.y.z"
}
```

### Basic usage example

The minimal usage for the module is as follows:

```hcl
module "aks" {
  source = "../.."

  name                = "example-aks"
  resource_group_name = "example-rg"

  default_node_pool = {
    name       = "system"
    vm_size    = "Standard_D2s_v3"
    node_count = 1
  }
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->