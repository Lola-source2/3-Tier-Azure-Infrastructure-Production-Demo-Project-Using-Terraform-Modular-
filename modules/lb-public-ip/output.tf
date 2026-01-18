# modules/lb-public-ip/output.tf
output "public_ip_id" {
  value = azurerm_public_ip.lb_public_ip.id
}