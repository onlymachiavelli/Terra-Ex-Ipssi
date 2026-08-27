output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.subnets.subnet_id
}

output "network_acl_id" {
  description = "ID of the network ACL"
  value       = module.subnets.network_acl_id
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.security_group.id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.compute.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.compute.private_ip
}
