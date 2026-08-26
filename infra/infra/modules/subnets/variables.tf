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

variable "vpc_id" {
  type        = string
  description = "VPC where the subnet and network ACL are created"
}

variable "cidr_block" {
  type        = string
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
}

variable "map_public_ip_on_launch" {
  type        = bool
  description = "Auto-assign public IPs to instances launched in this subnet"
  default     = false # fail-safe default
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach SSH (port 22) at the network ACL layer. No default on purpose (fail-safe default): must be chosen explicitly, mirroring the security group's ssh_allowed_cidr."

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.ssh_allowed_cidr))
    error_message = "Must be a valid IPv4 CIDR, e.g. 203.0.113.4/32"
  }
}

variable "http_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach HTTP (port 80) at the network ACL layer"
  default     = "0.0.0.0/0"
}
