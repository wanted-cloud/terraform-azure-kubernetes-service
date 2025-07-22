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

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>=4.20.0)

## Required Inputs

The following input variables are required:

### <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool)

Description: Configuration for the default node pool.

Type:

```hcl
object({
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
```

### <a name="input_name"></a> [name](#input\_name)

Description: Name of the AI Service resource.

Type: `string`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Name of the resource group in which the AI Service will be created.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_additional_node_pools"></a> [additional\_node\_pools](#input\_additional\_node\_pools)

Description: List of additional node pools to be created.

Type:

```hcl
list(object({
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
```

Default: `[]`

### <a name="input_dns_prefix"></a> [dns\_prefix](#input\_dns\_prefix)

Description: DNS prefix for the Azure Kubernetes Service.

Type: `string`

Default: `""`

### <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type)

Description: Type of identity to use for the Azure service plan.

Type: `string`

Default: `"SystemAssigned"`

### <a name="input_location"></a> [location](#input\_location)

Description: Location of the resource group in which the AI Service will be created, if not set it will be the same as the resource group.

Type: `string`

Default: `""`

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

Default: `""`

### <a name="input_sku_tier"></a> [sku\_tier](#input\_sku\_tier)

Description: SKU tier for the Azure Kubernetes Service.

Type: `string`

Default: `"Standard"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: Tags to be applied to the AI Service resources.

Type: `map(string)`

Default: `{}`

### <a name="input_user_assigned_identity_ids"></a> [user\_assigned\_identity\_ids](#input\_user\_assigned\_identity\_ids)

Description: List of user assigned identity IDs for the Azure service plan.

Type: `list(string)`

Default: `[]`

## Outputs

The following outputs are exported:

### <a name="output_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#output\_kubernetes\_cluster\_id)

Description: The ID of the Kubernetes cluster.

### <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name)

Description: The name of the Kubernetes cluster.

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
module "template" {
    source = "../.."
}
```
## Contributing

_Contributions are welcomed and must follow [Code of Conduct](https://github.com/wanted-cloud/.github?tab=coc-ov-file) and common [Contributions guidelines](https://github.com/wanted-cloud/.github/blob/main/docs/CONTRIBUTING.md)._

> If you'd like to report security issue please follow [security guidelines](https://github.com/wanted-cloud/.github?tab=security-ov-file).
---
<sup><sub>_2025 &copy; All rights reserved - WANTED.solutions s.r.o._</sub></sup>
<!-- END_TF_DOCS -->