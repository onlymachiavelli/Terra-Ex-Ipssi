variable "location" {
  type        = string
  description = "Azure region to deploy into"
  default     = "swedencentral"
}

variable "username" {
  type        = string
  description = "Used to prefix/tag resources, e.g. your name or handle"
}

variable "environment" {
  type        = string
  description = "dev | staging | prod"
  default     = "dev"
}

variable "vnet_cidr" {
  type        = string
  description = "CIDR block for the virtual network"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach SSH (port 22), enforced at the network security group. No default on purpose (fail-safe default): must be chosen explicitly."

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

variable "vm_size" {
  type        = string
  description = "Azure VM size"
  default     = "Standard_D2s_v3"
}

variable "public_key" {
  type        = string
  description = "SSH public key to install on the VM"
}

variable "has_public_ip" {
  type        = bool
  description = "Whether the VM gets a public IP"
  default     = false # fail-safe default
}
