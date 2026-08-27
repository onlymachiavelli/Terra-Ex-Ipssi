output "id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.this.public_ip
}

output "key_name" {
  description = "Name of the key pair attached to the instance"
  value       = aws_key_pair.this_keypair.key_name
}
