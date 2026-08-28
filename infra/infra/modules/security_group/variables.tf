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
  description = "Resource group the NSG is created in"
}

variable "location" {
  type        = string
  description = "Azure region the NSG is created in"
}

variable "subnet_id" {
  type        = string
  description = "Subnet the NSG is associated with"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach SSH (port 22). No default on purpose (fail-safe default): the caller must explicitly choose who can SSH in instead of silently opening it to 0.0.0.0/0."

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.ssh_allowed_cidr))
    error_message = "Must be a valid IPv4 CIDR, e.g. 203.0.113.4/32"
  }
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach HTTP (port 80)"
  default     = "0.0.0.0/0"
}
