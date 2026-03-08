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
