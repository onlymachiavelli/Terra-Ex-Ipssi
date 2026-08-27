variable "aws_region" {
  type        = string
  description = "AWS region to deploy into"
  default     = "us-east-1"
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

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for the subnet"
  default     = "us-east-1a"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "ssh_allowed_cidr" {
  type        = string
  description = "CIDR allowed to reach SSH (port 22), enforced at both the security group and network ACL layers. No default on purpose (fail-safe default): must be chosen explicitly."

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

variable "instance_ami" {
  type        = string
  description = "AMI of EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "public_key" {
  type        = string
  description = "SSH public key to install on the instance"
}

variable "has_public_ip" {
  type        = bool
  description = "Whether the instance gets a public IP"
  default     = false # fail-safe default
}
