# Sets global variables for this Terraform project.
variable environment {
  type = string
  description = "Environment short name (dev, stage, prod)"
}

locals {
  app_name = "flixtube-${var.environment}"
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

variable client_id {
}

variable client_secret {
}

variable app_version {
}

variable storage_account_name {
}

variable storage_access_key {
}
