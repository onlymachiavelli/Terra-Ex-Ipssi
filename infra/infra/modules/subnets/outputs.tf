output "subnet_id" {
  description = "ID of the subnet"
  value       = aws_subnet.this.id
}

output "network_acl_id" {
  description = "ID of the network ACL"
  value       = aws_network_acl.this.id
}
