# modules/keyvault/output.tf
output "key_vault_id" {
  value     = azurerm_key_vault.key_vault.id
  sensitive = true

}



output "key_vault_role_assignment_id" {
  value     = azurerm_role_assignment.key_vault_role_assignment.id
  sensitive = true
}

output "vmss_app_id_role_assignment_id" {
  value     = azurerm_role_assignment.vmss_app_id_role_assignment.id
  sensitive = true
}

 