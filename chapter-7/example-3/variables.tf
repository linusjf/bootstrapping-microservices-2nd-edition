# Sets global variables for this Terraform project.

variable app_name {
  default = "flixtube"
}

variable location {
  default = "eastus"
}

variable kubernetes_version {
  default = "1.31.1"
}

variable container_registry_name {
  default = "linusjfflixtube"
}
