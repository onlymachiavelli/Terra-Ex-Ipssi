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
  description = "Map of ingress rules, keyed by a unique rule name"
  default = {
    ssh = {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    http = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
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
