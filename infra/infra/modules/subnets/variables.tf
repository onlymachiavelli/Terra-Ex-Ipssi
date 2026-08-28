variable "username" {
  type = string
}

variable "environment" {
  type        = string
  description = "dev | staging | prod"

  validation {
    condition     = can(regex("^[a-z]+$", var.environment))
    error_message = "Must be a lowercase"
  }
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment of dev staging and prod"
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group the subnet is created in"
}

variable "virtual_network_name" {
  type        = string
  description = "Virtual network the subnet is created in"
}

variable "address_prefix" {
  type        = string
  description = "CIDR block for the subnet"
}
