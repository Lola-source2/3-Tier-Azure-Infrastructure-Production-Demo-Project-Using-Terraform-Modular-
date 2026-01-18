# Output the TLS private key details
output "tls_private_key_id" {
  value     = tls_private_key.ssh_key.id
  sensitive = true
}

output "tls_private_key_public_key_openssh" {
  value     = tls_private_key.ssh_key.public_key_openssh
  sensitive = true
}