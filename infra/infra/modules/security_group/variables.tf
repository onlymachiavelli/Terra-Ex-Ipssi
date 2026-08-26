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
  description = "VPC where the security group is created"
}

variable "description" {
  type        = string
  description = "Security group description"
  default     = "Managed by Terraform"
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

variable "ingress_rules" {
  # Each rule becomes its own aws_vpc_security_group_ingress_rule resource,
  # keyed by map key rather than inline blocks on aws_security_group -
  # HashiCorp warns against mixing inline rules with these resources.
  type = map(object({
    description = optional(string, "")
    from_port   = optional(number)
    to_port     = optional(number)
    ip_protocol = string
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
  }))
  description = "Extra ingress rules beyond the built-in ssh/http ones, keyed by a unique rule name"
  default     = {}
}

variable "egress_rules" {
  type = map(object({
    description = optional(string, "")
    from_port   = optional(number)
    to_port     = optional(number)
    ip_protocol = string
    cidr_ipv4   = optional(string)
    cidr_ipv6   = optional(string)
  }))
  description = "Map of egress rules, keyed by a unique rule name"
  default = {
    allow_all_outbound = {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}
