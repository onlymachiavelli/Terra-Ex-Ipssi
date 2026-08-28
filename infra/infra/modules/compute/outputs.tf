output "id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.this.id
}

output "private_ip" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip" {
  description = "Public IP address of the VM"
  value       = var.has_public_ip ? azurerm_public_ip.this[0].ip_address : null
}

output "admin_username" {
  description = "Admin username on the VM"
  value       = var.admin_username
}
