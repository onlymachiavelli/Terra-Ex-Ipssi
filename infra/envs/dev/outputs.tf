output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.subnets.subnet_id
}

output "network_security_group_id" {
  description = "ID of the network security group"
  value       = module.security_group.id
}

output "instance_id" {
  description = "ID of the virtual machine"
  value       = module.compute.id
}

output "instance_public_ip" {
  description = "Public IP address of the virtual machine"
  value       = module.compute.public_ip
}

output "instance_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = module.compute.private_ip
}
