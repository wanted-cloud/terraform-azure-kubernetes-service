variable "name" {
  description = "Name of the AI Service resource."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which the AI Service will be created."
  type        = string
}

variable "location" {
  description = "Location of the resource group in which the AI Service will be created, if not set it will be the same as the resource group."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be applied to the AI Service resources."
  type        = map(string)
  default     = {}
}

variable "dns_prefix" {
  description = "DNS prefix for the Azure Kubernetes Service."
  type        = string
  default     = ""
}

variable "default_node_pool" {
  description = "Configuration for the default node pool."
  type = object({
    name       = string
    node_count = number
    vm_size    = string
    subnet_id  = optional(string, null)
    tags       = optional(map(string), {})
    os_sku     = optional(string, "AzureLinux")
    zones      = optional(list(number), [])

    // Auto-scaling flag
    auto_scaling_enabled = optional(bool, false)
    // Auto-scaling configuration
    max_count  = optional(number, null)
    min_count  = optional(number, null)
    node_count = optional(number, null)
  })
}

variable "additional_node_pools" {
  description = "List of additional node pools to be created."
  type = list(object({
    name       = string
    node_count = number
    vm_size    = string
    subnet_id  = optional(string, null)
    tags       = optional(map(string), {})
    os_type    = optional(string, "Linux")
    os_sku     = optional(string, "AzureLinux")
    priority   = optional(string, "Regular")
    zones      = optional(list(number), [])

    // Auto-scaling flag
    auto_scaling_enabled = optional(bool, false)
    // Auto-scaling configuration
    max_count  = optional(number, null)
    min_count  = optional(number, null)
    node_count = optional(number, null)
  }))
  default = []
}

variable "identity_type" {
  description = "Type of identity to use for the Azure service plan."
  type        = string
  default     = "SystemAssigned"
}

variable "user_assigned_identity_ids" {
  description = "List of user assigned identity IDs for the Azure service plan."
  type        = list(string)
  default     = []
}

variable "private_cluster_enabled" {
  description = "Whether to enable private cluster for the Azure Kubernetes Service."
  type        = bool
  default     = false
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone to be used for the private cluster."
  type        = string
  default     = ""
}

variable "private_cluster_public_fqdn_enabled" {
  description = "Whether to enable public FQDN for the private cluster."
  type        = bool
  default     = false
}

variable "sku_tier" {
  description = "SKU tier for the Azure Kubernetes Service."
  type        = string
  default     = "Standard"

}