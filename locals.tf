locals {
  // Here you can define module metadata
  definitions = {
    tags = { ManagedBy = "Terraform" }
    resource_timeouts = {
      // AKS operations can take a long time — override the base 30m defaults
      default = { create = "60m", read = "5m", update = "60m", delete = "60m" }
    }
  }
}
