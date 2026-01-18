# modules/bastion_admin/output.tf

output "bastion_admin" {
  value = azurerm_bastion_host.bastion_host.id
}