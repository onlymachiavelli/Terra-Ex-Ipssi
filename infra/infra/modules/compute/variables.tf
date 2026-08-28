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
  description = "Resource group the VM is created in"
}

variable "location" {
  type        = string
  description = "Azure region the VM is created in"
}

variable "subnet_id" {
  type        = string
  description = "Subnet the VM's NIC is attached to"
}

variable "vm_size" {
  type        = string
  description = "Azure VM size"
  default     = "Standard_B1s"
}

variable "admin_username" {
  type        = string
  description = "Admin username on the VM (also used as the ansible_user)"
  default     = "ubuntu"
}

variable "public_key" {
  type = string
}

variable "has_public_ip" {
  type    = bool
  default = false #fail-safe default
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "ubuntu-24_04-lts"
}

variable "image_sku" {
  type    = string
  default = "server"
}

variable "image_version" {
  type    = string
  default = "latest"
}
