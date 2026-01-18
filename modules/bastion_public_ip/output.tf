# modules/bastion_public_ip/output.tf
output "bastion_public_ip_id" {
  value = azurerm_public_ip.bastion_public_ip.id
}